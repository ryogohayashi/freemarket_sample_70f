class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :images, dependent: :destroy
  belongs_to :category
  # 追加実装の為コメントアウト
  belongs_to :brand, optional: true
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to :seller, class_name: "User"
  # belongs_to :buyer, class_name: "User"

  accepts_nested_attributes_for :images

  validates :images, presence: { message: 'は投稿してください。'}
  validates :name, presence: { message: 'は入力してください。'}
  validates :introduction, presence: { message: 'は入力してください。'}
  validates :category_id, presence: true, on: :create 
  # 追加実装の為コメントアウト
  # validates :brand, presence: true, allow_blank: true
  validates :condition, presence: { message: 'を選択してください。'}
  validates :postage_payer, presence: { message: 'を選択してください。'}
  validates :prefecture_code, presence: { message: 'は都道府県を選択してください。'}
  validates :preparation_day, presence: { message: 'を選択してください。'}
  validates :price, numericality: { message: 'は入力してください。'}

end
