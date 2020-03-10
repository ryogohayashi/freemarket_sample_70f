FactoryBot.define do

  factory :user do
    nickname              {"テスト"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"田中"}
    first_name            {"隆"}
    family_name_kana      {"タナカ"} 
    first_name_kana       {"タカシ"} 
    birth_year            {"1993"}
    birth_month           {"1"}
    birth_day             {"1"}
  end

end
