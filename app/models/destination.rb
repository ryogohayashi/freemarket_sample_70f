class Destination < ApplicationRecord
  belongs_to :user, optional: true


  validates :post_code, presence: true,
  format: {with: /\A[0-9]{3}[0-9]{4}\z/, message: 'は7桁、ハイフンなしで入力してください。'}
  validates :prefecture_code, presence: { message: 'は都道府県を選択してください。'}
  validates :city, presence: { message: 'は入力してください。'}
  validates :house_number, presence: { message: 'は入力してください。'}
  # validates :building
  # validates :phone_number, format: {with: /A\d{10}z|A\d{11}z/, message: 'はハイフンなしで入力してください'}

end
