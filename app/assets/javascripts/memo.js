// // このページはmemo用です。宜しく御願いします。

// // credit_card_controller
// // def new
// //   @user = User.find_by(params[: user_id])
// // credit_card = CreditCard.where(user_id: current_user.id)
// // redirect_to action: "index" if credit_card.exists ?
// //   end

// //   def pay #payjpとCreditCardのデータベース作成を実施。
// // Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
// // customer = Payjp:: Customer.create(
// //   card: params['payjp-token'],
// //   metadata: { user_id: current_user.id }
// // ) #念の為metadataにuser_idを入れた
// // @credit_card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
// // if @credit_card.save
// // redirect_to action: "index"
// //       else
// // redirect_to action: "new"
// // end
// // end

// // def show #Cardのデータpayjpに送り情報を取り出します
// // credit_card = CreditCard.where(user_id: current_user.id).first
// // if credit_card.blank ?
// //   redirect_to action: "new"
// // else
// //   Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
// // customer = Payjp:: Customer.retrieve(credit_card.customer_id)
// // @default_card_information = customer.cards.retrieve(credit_card.card_id)
// // end
// // end



// // before_action :authenticate_user!
// // before_action :set_product, only: [:edit, :buy]
// // require "payjp"




// // def delete 
// //   card = Card.where(user_id: current_user.id).first
// //     Payjp.api_key = ENV["KEY"]
// //     customer = Payjp::Customer.retrieve(card.customer_id)
// //     customer.delete
// //     if card.delete
// //       redirect_to action: "new", notice: "削除しました"
// //     else 
// //       redirect_to action: "index", alert: "削除できませんでした"
// //     end

// // end

// // def index
// //   card = Card.find_by(user_id: current_user.id)
// //     Payjp.api_key = ENV["KEY"]
// //     customer = Payjp::Customer.retrieve(card.customer_id)
// //     @default_card_information = customer.cards.retrieve(card.card_id)

// //     @card_brand = @default_card_information.brand      
// //     case @card_brand
// //     when "Visa"
// //       @card_src = "visa.png"
// //     when "JCB"
// //       @card_src = "jcb.gif"
// //     when "MasterCard"
// //       @card_src = "mastercard.png"
// //     when "American Express"
// //       @card_src = "american-express.png"
// //     when "Discover"
// //       @card_src = "discover.png"
// //     end

// //   end

// //   def edit
// //     Payjp.api_key = ENV["KEY"]
// //     card = Card.where(user_id: current_user.id).first
// //     @address = Address.find_by(user_id: current_user.id)
// //     if current_user.id == @product.id
// //       redirect_to root_path
// //     elsif @product.status == "2"
// //       redirect_to root_path
// //     end
// //     if card.present?
// //       customer = Payjp::Customer.retrieve(card.customer_id)
// //       @default_card_information = customer.cards.retrieve(card.card_id)
// //     end
// //   end

// //   def buy
// //     Payjp.api_key = ENV['KEY']
// //     card = Card.where(user_id: current_user.id).first
// //     if current_user.id != @product.id && @product.status == "1"
// //       Payjp::Charge.create(
// //       amount: @product.price,
// //       customer: card.customer_id, 
// //       currency: 'jpy'
// //     )
// //     end
// //   if @product.update(status: 2)
// //     redirect_to action: 'show'
// //   else
// //     redirect_to action: 'edit', notice: "購入できませんでした"
// //   end
// //   end

// //   private

// //   def set_product
// //     @product = Product.find(params[:id])
// //   end


// // このページはmemo用です。宜しく御願いします。

// $(function () {
//   function appendOption(category) { // optionの作成
//     var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
//     return html;
//   }
//   function appendChidrenBox(insertHTML) { // 子セレクトボックスのhtml作成
//     var childSelectHtml = '';
//     childSelectHtml = `<div class='product-select-wrapper' id= 'children_wrapper'>
//                           <div class='main-box__form__group__select'>
//                             <select class="main-box__form__group__name-form" id="child_category" name="">
//                               <option value="---" data-category="---">---</option>
//                               ${insertHTML}
//                             </select>
//                           </div>
//                         </div>`;
//     $('.main-box__form__group__children').append(childSelectHtml);
//   }
//   function appendgrandChidrenBox(insertHTML) { // 孫セレクトボックスのhtml作成
//     var grandchildrenSelectHtml = '';
//     grandchildrenSelectHtml = `<div class='product-select-wrapper' id= 'grandchildren_wrapper'>
//                                 <div class='main-box__form__group__select'>
//                                   <select class="main-box__form__group__name-form" id="grandchild_category" name="product[category_id]">
//                                     <option value="---" data-category="---">---</option>
//                                     ${insertHTML} 
//                                   </select>
//                                 </div>
//                               </div>`;
//     $('.main-box__form__group__children').append(grandchildrenSelectHtml);
//   }



//   $('#category_select').on('change', function () {  // 親セレクトボックスの選択肢を変えたらイベント発火
//     var productcategory = document.getElementById('category_select').value;
//     // ↑ productcategoryに選択した親のvalueを代入
//     if (productcategory != '') {
//       // ↑ productcategoryが空ではない場合のみAjax通信を行う｡選択肢を初期選択肢'---'に変えると､通信失敗となってしまうため｡
//       $.ajax({
//         url: 'category_children',
//         type: 'GET',
//         data: { parent_name: productcategory },
//         dataType: 'json'
//       })
//         .done(function (children) {  // 送られてきたデータをchildrenに代入
//           $('#children_wrapper').remove(); //親が変更された時、子以下を削除するする
//           $('#grandchildren_wrapper').remove();
//           var insertHTML = '';
//           children.forEach(function (child) {
//             insertHTML += appendOption(child);
//           });
//           appendChidrenBox(insertHTML);
//         })
//         .fail(function () {
//           alert('カテゴリー取得に失敗しました');
//         })
//     } else {
//       $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
//       $('#grandchildren_wrapper').remove();
//     }
//   });


//   // document､もしくは親を指定しないと発火しない
//   $('.main-box__form__group__children').on('change', '#child_category', function () {
//     var childId = $('#child_category option:selected').data('category');
//     if (childId != '') {
//       $.ajax({
//         url: 'category_grandchildren',
//         type: 'GET',
//         data: { childId: childId },
//         dataType: 'json'
//       })
//         .done(function (grandchildren) {
//           if (grandchildren.length != 0) {
//             $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除するする
//             var insertHTML = '';
//             grandchildren.forEach(function (grandchild) {
//               insertHTML += appendOption(grandchild);
//             });
//             appendgrandChidrenBox(insertHTML);
//           }
//         })
//         .fail(function () {
//           alert('カテゴリー取得に失敗しました');
//         })
//     } else {
//       $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
//     }
//   });
// });
