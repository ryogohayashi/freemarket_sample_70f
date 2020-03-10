require 'rails_helper'
describe Destination do
  describe '#create' do
    # 1. 全てのカラムが存在すれば登録できること
    it "全てのカラムのvalidationをクリアできれば登録できる" do
      destination = build(:destination)
      expect(destination).to be_valid
    end

    # 2. post_codeが空では登録できないこと
    it "post_codeが空白だと登録できない" do
      destination = build(:destination, post_code: nil)
      destination.valid?
      expect(destination.errors[:post_code]).to include("can't be blank")
    end

    # 3. prefecture_codeが空では登録できないこと
    it "prefecture_codeが空白だと登録できない" do
      destination = build(:destination, prefecture_code: nil)
      destination.valid?
      expect(destination.errors[:prefecture_code]).to include("can't be blank")
    end

    # 4. cityが空では登録できないこと
    it "cityが空白だと登録できない" do
      destination = build(:destination, city: nil)
      destination.valid?
      expect(destination.errors[:city]).to include("can't be blank")
    end

    # 5. cityが空では登録できないこと
    it "cityが空白だと登録できない" do
      destination = build(:destination, city: nil)
      destination.valid?
      expect(destination.errors[:city]).to include("can't be blank")
    end

    # 6. house_numberが空では登録できないこと
    it "house_numberが空白だと登録できない" do
      destination = build(:destination, house_number: nil)
      destination.valid?
      expect(destination.errors[:house_number]).to include("can't be blank")
    end

    # 7. post_codeが3桁では登録できないこと
    it "post_codeが3桁では登録できない" do
      destination = build(:destination, post_code: "333")
      destination.valid?
      expect(destination.errors[:post_code]).to include("は7桁、ハイフンなしで入力してください")
    end
    

  end
end
