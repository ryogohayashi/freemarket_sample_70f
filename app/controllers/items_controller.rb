class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]
  before_action :set_purchased, only: [:purchased]

  def new
    @item = Item.new
    @item.images.new
    @category = Category.all.order("id ASC").limit(13)
    @category_parent_array = Category.where(ancestry: nil).pluck(:name)
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end


  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    # unless @item.save
    #   flash[:alert] = @item.errors.full_messages
    #   flash[:data] = Item.new(item_params)
    #   render :new
      # redirect_to new_user_item_path(current_user)
    if @item.save
      redirect_to :root
    else
      @category = Category.all.order("id ASC").limit(13)
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      @item.images.new
      # render :new
      # render action: :new
      redirect_to new_item_path(current_user), flash: { error: @item.errors.full_messages }
    end
  end

  def show
    @item = Item.find(params[:id])
    @image = @item.images.includes(:item)
    @condition = Condition.find(@item.condition_id)
    @postage_payer = PostagePayer.find(@item.postage_payer_id)
    # @size = Size.find(@item.size_id)
    @preparation_day = PreparationDay.find(@item.preparation_day_id)
    @category = Category.find(@item.category_id)
    @seller = User.find(@item.seller_id)
  end


  def purchased
    Payjp.api_key= ENV["PAYJP_PRIVATE_KEY"]
    charge = Payjp::Charge.create(
      amount: @item.price,
      customer: Payjp::Customer.retrieve(@credit_card.customer_id),
      currency: 'jpy'
    )
    @buyer_id= Item.find(params[:id])
    @buyer_id.update(buyer_id: current_user.id)
    redirect_to root_path
  end

  def destroy
      if @item.destroy
        redirect_to root_path
      else
        render user_item_path(item.user_id,item.id)
      end
  end


  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :condition_id, :postage_payer_id, :prefecture_code, :size_id, :preparation_day_id, :buyer_id ,:category_id, :brand_id, [images_attributes: [:image, :item_id, :created_at, :update_at]]).merge(user_id: current_user.id, seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_purchased
    @credit_card = CreditCard.find_by(user_id: current_user.id)
    @item = Item.find(params[:id])
  end
end
