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
      customer = Payjp::Customer.create(
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) 
      @credit_card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit_card.save
        redirect_to action: "index"
      else
        redirect_to action: "new"
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
