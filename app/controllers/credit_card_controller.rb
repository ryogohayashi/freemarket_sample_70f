class CreditCardController < ApplicationController
  before_action :authenticate_user!
  require "payjp"

  def index
    @user = User.find_by(params[:user_id])
    @credit_card = CreditCard.where(user_id: current_user.id)
    if @credit_card.present?
      @credit_card = CreditCard.where(user_id: current_user.id).first
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
    else
      redirect_to action: "new" 
    end
  end

  def new
    credit_card = CreditCard.where(user_id: current_user.id)
    redirect_to action: "index" if credit_card.exists?
  end

  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
        flash[:notice] = 'クレジットカードの登録が完了しました'
      else
        redirect_to action: "pay"
        flash[:alert] = 'クレジットカード登録に失敗しました'
      end
    end
  end

  def buy
    #商品/ユーザー/クレジットカードの変数設定
    @user = current_user
    @credit_card = CreditCard.where(user_id: current_user.id).first
    @destination = Destination.where(user_id: current_user.id).first
    @item = Item.find(params[:id])
  #Payjpの秘密鍵を取得
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
  #Payjpから顧客情報を取得し、表示
    customer = Payjp::Customer.retrieve(@credit_card.customer_id)
    @credit_card_information = customer.cards.retrieve(@credit_card.card_id)
    @card_brand = @creditcard_information.brand 
    case @card_brand
    when "Visa"
      @card_src = "visa.png"
    when "JCB"
      @card_src = "jcb.png"
    when "MasterCard"
      @card_src = "master.png"
    when "American Express"
      @card_src = "american.png"
    when "Diners Club"
      @card_src = "diners.png"
    when "Discover"
      @card_src = "discover.png"
    end
  end


  def delete #PayjpとCreditCardデータベースを削除
    @credit_card = CreditCard.where(user_id: current_user.id).first
    if @credit_card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      customer.delete
      @credit_card.delete
    end
      redirect_to action: "new"
  end

end
