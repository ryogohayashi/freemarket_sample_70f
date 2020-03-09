class Destination < ApplicationRecord
  belongs_to :user, optional: true

  validates :destination_family_name, presence: true,format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は日本語で入力して下さい。'}
  validates :destination_first_name, presence: true,format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は日本語で入力して下さい。'}
  validates :destination_family_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: 'は全角カタカナで入力して下さい。'}
  validates :destination_first_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: '全角カタカナで入力して下さい。'}
  validates :post_code, presence: true,
  format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は7桁、ハイフンなしで入力してください'}
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
  # validates :building
  validates :phone_number, format: {with: /A\d{10}$|^\d{11}Z/, message: 'はハイフンなしで入力してください'}

 

  

end
