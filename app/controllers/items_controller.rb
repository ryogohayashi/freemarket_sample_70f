class ItemsController < ApplicationController
  def new
    @item = Item.new
    @item.images.new
  end

  def create
    # 未実装の為コメントアウト
    # params[:category_id] = 1  #zissouno test 
    # params[:brand_id] = 1
    @item = Item.new(item_params)
    if @item.save
      redirect_to :root
    else
      render :new
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :brand_id, :condition_id, :postage_payer_id, :prefecture_code, :size_id, :preparation_day_id, :category_id, [images_attributes: [:image, :item_id, :created_at, :update_at]]).merge(user_id: current_user.id, seller_id: current_user.id, buyer_id: current_user.id)
  end
end
