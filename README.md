# freemarket_sample_70f
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique, true, index: ture|
|password|string|null: false|
|password_confrimation|string|null: false|
### Association
- has_many  : seller_items, foreign_key: "seller_id", class_name: "items"
- has_many  : buyer_items, foreign_key: "buyer_id", class_name: "items"
- has_one   : profile, dependent: :destroy
- has_one   : destination, dependent: :destory
- has_one   : credit_card, dependent: :destroy


## Profilesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|family_name|string|null: false|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|birth_year|date|null: false|
|birth_month|date|null: false|
|birth_day|date|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user


## destinationsテーブル
|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null: false|
|destination_famliy_name|string|null: false|
|destination_first_name_kana|string|null: false|
|destination_family_name_kana|string|null: false|
|post_code|inteder|null: false|
|prefecture_code|inteder|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_number|string||
|phone_number|integer|
|user_id|integer|null: false, foreign_key: ture|
### Association
- belongs_to :user
- Gem :jp_prefectureを使用して都道府県コードを取得


# credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false, unique: true|
|expiration_month|integer|null: false|
|expiration_year|integer|null: false|
|security_code|integer|null: false|
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
|postage_type_id|integer|null: false, foreign_key: true|
|prefecture_code|integer| null: false|
|size_id |integer|null: false, foreign_key: true|
|preparation_day_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
|trading_status|enum|null: false|
|seller_id|integer|null: false, foreign_key: true|
|buyer_id|integer|foreign_key: true) 
|deal_closed_date|timestamp||


### Association
- has_many   :images, dependent: :destroy
- belongs_to :category
- belongs_to :brand
- belongs_to :active_hash :size
- belongs_to :active_hash :condition
- belongs_to :active_hash :postage_payer
- belongs_to :active_hash :postage_type
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