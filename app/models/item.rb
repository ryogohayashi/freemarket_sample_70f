class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :images, dependent: :destroy
  # belongs_to :category
  # belongs_to :brand
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :preparation_day
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"

  accepts_nested_attributes_for :images
  # , allow_destroy: true

  # バリデーション未実装の為コメントアウト
  # validates :images, presence: true { message: 'は投稿してください。'}
  # validates :name, presence: true { message: 'は入力してください。'}
  # validates :introduction, presence: true { message: 'は入力してください。'}
  # validates :category, presence: true { message: 'を選択してください。'}
  # validates :brand, presence: true, allow_blank: true
  # validates :condition, presence: true { message: 'を選択してください。'}
  # validates :postage_payer, presence: true { message: 'を選択してください。'}
  # validates :prefecture_code, presence: true { message: 'は都道府県を選択してください。'}
  # validates :preparation_day, presence: true { message: 'を選択してください。'}
  # validates :price, numericality: true { message: 'は入力してください。'}

end
