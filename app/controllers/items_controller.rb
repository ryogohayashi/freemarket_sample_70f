class ItemsController < ApplicationController
  
  def new
    @item = Item.new
    @item.images.new
    @category = Category.all.order("id ASC").limit(13)
    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    Category.where(ancestry: nil).each do |parent|
       @category_parent_array << parent.name
    end
  end

  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
 end

 # 子カテゴリーが選択された後に動くアクション
 def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
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

  def show
    @item = Item.find(params[:id])
    @image = @item.images.includes(:item)
    @condition = Condition.find(@item.condition_id)
    @postage_payer = PostagePayer.find(@item.postage_payer_id)
    @size = Size.find(@item.size_id)
    @preparation_day = PreparationDay.find(@item.preparation_day_id)
    @category = Category.find(@item.category_id)
    @seller = User.find(@item.seller_id)
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :brand_id, :condition_id, :postage_payer_id, :prefecture_code, :size_id, :preparation_day_id, :category_id, [images_attributes: [:image, :item_id, :created_at, :update_at]]).merge(user_id: current_user.id, seller_id: current_user.id, buyer_id: current_user.id)
  end

end

# @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)