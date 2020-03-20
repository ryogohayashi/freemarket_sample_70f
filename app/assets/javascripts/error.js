// // $(function () {

// //   // submit()に関数をバインド
// //   $('form').submit(function () {

// //     // もしテキストボックスが空欄だったら…
// //     if ($('#label-box--0').val() == '') {

// //       // 警告を出す
// //       alert('空欄です！');

// //       // 処理を中断
// //       return false;

// //     }
// //     if ($('#parent_category').val() == '') {

// //       // 警告を出す
// //       alert('空欄があります！');

// //       // 処理を中断
// //       return false;

// //     }
// //   });
// // });







// class ItemsController < ApplicationController
//   def new
//     @item = Item.new
//     @item.images.new
//     @category = Category.all.order("id ASC").limit(13)
//     @category_parent_array = Category.where(ancestry: nil).pluck(:name)

//   end

//   def get_category_children
//     @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
//   end


//   def get_category_grandchildren
//     @category_grandchildren = Category.find("#{params[:child_id]}").children
//   end

//   def create
//     @item = Item.new(item_params)
//     # unless @item.save
//     #   flash[:alert] = @item.errors.full_messages
//     #   flash[:data] = Item.new(item_params)
//     #   render :new
//       # redirect_to new_user_item_path(current_user)
//     if @item.save
//       redirect_to :root
//     else
//       @category = Category.all.order("id ASC").limit(13)
//       @category_parent_array = Category.where(ancestry: nil).pluck(:name)
//       @item.images.new
//       # render :new
//       # render action: :new
//       redirect_to new_user_item_path(current_user), flash: { error: @item.errors.full_messages }
//     end
//   end

//   private
//   def item_params
//     params.require(:item).permit(:name, :introduction, :price, :brand_id, :condition_id, :postage_payer_id, :prefecture_code, :size_id, :preparation_day_id, :category_id, [images_attributes: [:image, :item_id, :created_at, :update_at]]).merge(user_id: current_user.id, seller_id: current_user.id, buyer_id: current_user.id)
//   end
// end
