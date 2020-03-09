class Destination < ApplicationRecord
  belongs_to :user, optional: true


  validates :post_code, presence: true,
  format: {with: /\A[0-9]{3}[0-9]{4}\z/, message: 'は7桁、ハイフンなしで入力してください'}
  validates :prefecture_code, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
  # validates :building
  # validates :phone_number, format: {with: /A\d{10}z|A\d{11}z/, message: 'はハイフンなしで入力してください'}

 

  

end
