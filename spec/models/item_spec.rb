require 'rails_helper'
describe Item do
  describe '#create' do
    # 1. 全てのカラムが存在すれば登録できること
    it "全てのカラムのvalidationをクリアできれば登録できる" do
      item = build(:item)
      expect(item).to be_valid
    end

    # 2. nameが空では登録できないこと
    it "nameが空白だと登録できない" do
      item = build(:item, name: nil)
      item.valid?
      expect(item.errors[:name]).to include("は１文字以上入力してください。")
    end

    # 3. introductionが空では登録できないこと
    it "introductionが空だと登録できない " do
      item = build(:item, introduction: nil)
      item.valid?
      expect(item.errors[:introduction]).to include("は１文字以上入力してください。")
    end

    # 4. categoryが空では登録できないこと
    it "categoryが空だと登録できない " do
      user = build(:item, category: nil)
      user.valid?
      expect(item.errors[:category]).to include("を選択してください。")
    end

    # 5. conditionが空では登録できないこと
    it "conditionが空白だと登録できない" do
      item = build(:item, condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("を選択してください。")
    end

    # 6. postage_payerが空では登録できないこと
    it "postage_payerが空白だと登録できない" do
      item = build(:item, postage_payer: nil)
      item.valid?
      expect(item.errors[:postage_payer]).to include("を選択してください。")
    end

    # 7. prefecture_codeが空では登録できないこと
    it "prefecture_codeが空白だと登録できない" do
      item = build(:item, prefecture_code: nil)
      item.valid?
      expect(item.errors[:prefecture_code]).to include("は都道府県を選択してください。")
    end

    # 8. preparation_dayが空では登録できないこと
    it "preparation_dayが空白だと登録できない" do
      item = build(:item, preparation_day: nil)
      item.valid?
      expect(item.errors[:preparation_day]).to include("を選択してください。")
    end

    # 9. priceが空では登録できないこと
    it "priceが空白だと登録できない" do
      item = build(:item, price: nil)
      item.valid?
      expect(item.errors[:price]).to include("は入力してください。")
    end
  end
end
