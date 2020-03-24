class CreditCardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_buy, only: [:buy]
  require "payjp"

  def index
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
    @credit_card = CreditCard.where(user_id: current_user.id)
    redirect_to action: "index" if @credit_card.exists?
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
      @credit_card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit_card.save
        redirect_to action: "index"
        flash[:notice] = 'クレジットカードの登録が完了しました'
      else
        redirect_to action: "pay"
        flash[:alert] = 'クレジットカード登録に失敗しました'
      end
    end
  end

  def show
    @credit_card = CreditCard.where(user_id: current_user.id)
    if @credit_card.blank?
      redirect_to action: "new" 
      flash[:touroku] = '商品の購入には、クレジットカードの登録が必要となります。'
    else
      @credit_card = CreditCard.where(user_id: current_user.id).first
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@credit_card.customer_id)
      @default_card_information = customer.cards.retrieve(@credit_card.card_id)
      @destination = Destination.where(user_id: current_user.id).first
      @user = current_user
      @item = Item.find(params[:id])
      @image = @item.images.includes(:item)
      @condition = Condition.find(@item.condition_id)
      @postage_payer = PostagePayer.find(@item.postage_payer_id)
      @preparation_day = PreparationDay.find(@item.preparation_day_id)
      @category = Category.find(@item.category_id)
      @seller = User.find(@item.seller_id)
      
    end
  end

  def buy
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(@creditcard.customer_id)
    @creditcard_information = customer.cards.retrieve(@creditcard.card_id)
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


  private

  def set_buy
    @images = @item.images.includes(:item)
    @credit_card = CreditCard.find_by(user_id: current_user.id)
    @adress = Address.find_by(user_id: current_user.id)
    @item = item.find(params[:id])
  end
end
