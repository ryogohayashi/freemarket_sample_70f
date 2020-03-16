class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :category
  belongs_to :brand
  belongs_to :active_hash :condition
  belongs_to :active_hash :postage_payer
  belongs_to :active_hash :preparation_day
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
end
