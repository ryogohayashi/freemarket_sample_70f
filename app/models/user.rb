class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: { message: 'は１文字以上入力してください。' }
  validates :family_name, presence: true,format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は日本語で入力して下さい。'}
  validates :first_name, presence: true,format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は日本語で入力して下さい。'}
  validates :family_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: 'は全角カタカナで入力して下さい。'}
  validates :first_name_kana, presence: true, format: { with: /[\p{katakana} ー－&&[^ -~｡-ﾟ]]+/, message: 'は全角カタカナで入力して下さい。'}
  validates :birth_year, presence: { message: 'は１文字以上入力してください。' }
  validates :birth_month, presence: { message: 'は１文字以上入力してください。' }
  validates :birth_day, presence: { message: 'は１文字以上入力してください。' }
  has_one :destination
  
end
