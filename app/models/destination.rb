class Destination < ApplicationRecord
  belongs_to :user, optional: true

  validates :destination_first_name, :destination_family_name, :destination_first_name_kana, :destination_family_name_kana, :post_code, :prefecture, :city, :house_number, presence: true

  validates :address_number, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :town, presence: true
end
