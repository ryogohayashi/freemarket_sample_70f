class TopController < ApplicationController
  def index
    @user = User.where(user: current_user)
    @items = Item.limit(3).order('id DESC')
    @items1 = Item.limit(3).offset(3).order('id DESC')
    @items2 = Item.limit(3).offset(6).order('id DESC')
  end

  def show
    @item = Item.find(params[:id])
    @image = @item.images.includes(:item)
    @condition = Condition.find(@item.condition_id)
    @postage_payer = PostagePayer.find(@item.postage_payer_id)
    @preparation_day = PreparationDay.find(@item.preparation_day_id)
    @category = Category.find(@item.category_id)
    @seller = User.find(@item.seller_id)
  end
end
