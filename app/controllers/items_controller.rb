class ItemsController < ApplicationController
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
    # 追加実装の為コメントアウト
    # unless @item.save
    #   flash[:alert] = @item.errors.full_messages
    #   flash[:data] = Item.new(item_params)
    #   render :new
    #   redirect_to new_user_item_path(current_user)
    if @item.save
      redirect_to :root
    else
      @category = Category.all.order("id ASC").limit(13)
      @category_parent_array = Category.where(ancestry: nil).pluck(:name)
      @item.images.new
      # 追加実装の為コメントアウト
      # render :new
      # render action: :new
      redirect_to new_user_item_path(current_user), flash: { error: @item.errors.full_messages }
    end
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

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :condition_id, :postage_payer_id, :prefecture_code, :size_id, :preparation_day_id, :category_id, [images_attributes: [:image, :item_id, :created_at, :update_at]]).merge(user_id: current_user.id, seller_id: current_user.id, buyer_id: current_user.id, brand_id: current_user.id)
  end
end
