class Destination < ApplicationRecord
  belongs_to :user, optional: true

  validates :destination_family_name, presence: true,format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は日本語で入力して下さい。'}
  validates :destination_first_name, presence: true,format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は日本語で入力して下さい。'}
  validates :destination_family_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: 'は全角カタカナで入力して下さい。'}
  validates :destination_first_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: '全角カタカナで入力して下さい。'}
  validates :post_code, presence: true,format: {with: /^\d{7}$/, message: 'は7桁、ハイフンなしで入力してください'}
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
  validates :building
  validates :phone_number

  include JpPrefecture
  jp_prefecture :prefecture
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end


end
