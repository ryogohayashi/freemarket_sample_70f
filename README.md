# はじめに
未経験からエンジニアを目指しております。
チームで開発を行いました。お手数ですが、ご覧頂けますと幸いです。

# FURIMA(フリーマーケットアプリとなります。)

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique, true, index: ture|
|password|string|null: false|
|password_confirmation|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|


### Association
- has_many  : seller_items, foreign_key: "seller_id", class_name: "items"
- has_many  : buyer_items, foreign_key: "buyer_id", class_name: "items"
- has_one   : destination, dependent: :destory
- has_one   : credit_card, dependent: :destroy



## destinationsテーブル
|Column|Type|Options|
|------|----|-------|
|post_code|inteder|null: false|
|prefecture_code|integer|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_number|string||
|phone_number|string|
|user_id|integer|null: false, foreign_key: ture|
### Association
- belongs_to :user
- Gem :jp_prefectureを使用して都道府県コードを取得


# credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|customer_id|string|null: false|
|card_id|string|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|price|integer|null: falce|
|brand_id|inteder|null: false, foreign_key: ture|
|condition_id|integer|null: false, foreign_key: ture|
|postage_payer_id|integer|null: false, foreign_key: true|
|prefecture_code|integer| null: false|
|preparation_day_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|trading_status|enum|null: false|
|user_id|integer|null: false, foreign_key: true|
|seller_id|integer|null: false, foreign_key: true|
|buyer_id|integer|foreign_key: true) 



### Association
- has_many   :images, dependent: :destroy
- belongs_to :category
- belongs_to :brand
- belongs_to :active_hash :condition
- belongs_to :active_hash :postage_payer
- belongs_to :active_hash :preparation_day
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- Gem :jp_prefectureを使用して都道府県コードを取得

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|url|string|null: false|
### Association
- belongs_to :item

## Categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :items


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
### Association
- has_many :items


## sizes(active_hash)モデル
|Column|Type|Options|
|------|----|-------|
|size|string|null: false|
### Association
- has_many :items

## conditions(active_hash)モデル
|Column|Type|Options|
|------|----|-------|
|condition|string|null: false|
### Association
- has_many :items

## postage_payers(active_hash)モデル
|Column|Type|Options|
|------|----|-------|
|postage_payer|string|null: false|
### Association
- has_many :items

## preparation_days(active_hash)モデル
|Column|Type|Options|
|------|----|-------|
|preparation_day|string|null: false|
### Association
- has_many :items

## Postage_types(active_hash)モデル
|Column|Type|Options|
|------|----|-------|
|postage_type|string|null: false|
### Association
- has_many :items

### さいごに
ご覧頂きありがとうございました。
ご助言等頂けますと幸いです。


