require 'rails_helper'
describe User do
  describe '#create' do
    # 1. 全てのカラムが存在すれば登録できること
    it "全てのカラムのvalidationをクリアできれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    # 2. nicknameが空では登録できないこと
    it "nicknameが空白だと登録できない" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # 3. emailが空では登録できないこと
    it "emailが空白だと登録できない" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end
    
    # 4. 重複したemailが存在する場合登録できないこと
    it "emailが重複している場合、登録できない" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # 5. passwordが7文字以上であれば登録できること
    it "passwordが7文字以上だと登録できる " do
      user = build(:user, password: "00000000", password_confirmation: "00000000")
      user.valid?
      expect(user).to be_valid
    end

    # 6. passwordが6文字以下であれば登録できないこと
    it "passwordが6文字以下だと登録できない " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

    # 7. passwordが存在してもpassword_confirmationが空では登録できないこと
    it "確認用passwordが空白だと登録できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # 8. family_nameが空では登録できないこと
    it "family_nameが空白だと登録できない" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    # 9. first_nameが空では登録できないこと
    it "first_nameが空白だと登録できない" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    # 10. family_name_kanaが空では登録できないこと
    it "family_name_kanaが空白だと登録できない" do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end

    # 11. first_name_kanaが空では登録できないこと
    it "first_name_kanaが空白だと登録できない" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    # 12. birth_yearが空では登録できないこと
    it "birth_yearが空白だと登録できない" do
      user = build(:user, birth_year: nil)
      user.valid?
      expect(user.errors[:birth_year]).to include("can't be blank")
    end

    # 13. birth_monthが空では登録できないこと
    it "birth_mnthが空白だと登録できない" do
      user = build(:user, birth_month: nil)
      user.valid?
      expect(user.errors[:birth_month]).to include("can't be blank")
    end

    # 14. birth_dayが空では登録できないこと
    it "birth_dayが空白だと登録できない" do
      user = build(:user, birth_day: nil)
      user.valid?
      expect(user.errors[:birth_day]).to include("can't be blank")
    end
  end

  describe '#katakana' do
    # 15. family_name_kanaが全角カタカナでないと登録できないこと
    it 'family_name_kanaがローマ字ではなく、全角カタカナでないと登録できない' do
      user = build(:user, family_name_kana: "tanaka")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は全角カタカナで入力して下さい。")
    end

     # 16. family_name_kanaが全角カタカナでないと登録できないこと
    it 'family_name_kanaが半角カタカナではなく、全角カタカナでないと登録できない' do
      user = build(:user, family_name_kana: "ﾀﾅｶ")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は全角カタカナで入力して下さい。")
    end

    # 17. family_name_kanaが全角カタカナなので、登録できること
    it 'family_name_kanaが全角カタカナなので登録できる' do
      user = build(:user, family_name_kana: "タナカ")
      expect(user).to be_valid
    end

    # 18. first_name_kanaが全角カタカナでないと登録できないこと
    it 'first_name_kanaがローマ字ではなく、全角カタカナでないと登録できない' do
      user = build(:user, first_name_kana: "takashi")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい。")
    end

    # 19. family_name_kanaが全角カタカナでないと登録できないこと
    it 'first_name_kanaが半角カタカナではなく、全角カタカナでないと登録できない' do
      user = build(:user, first_name_kana: "ﾀｶｼ")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい。")
    end

    # 20. family_name_kanaが全角カタカナなので、登録できること
    it 'first_name_kanaが全角カタカナなので登録できる' do
      user = build(:user, first_name_kana: "タカシ")
      expect(user).to be_valid
    end
  end

  describe '#zenkaku' do
    # 15. family_nameが全角日本語でないと登録できないこと
    it 'family_nameがローマ字ではなく、全角日本語でないと登録できない' do
      user = build(:user, family_name: "tanaka")
      user.valid?
      expect(user.errors[:family_name]).to include("は日本語で入力して下さい。")
    end

     # 16. first_nameが全角日本語でないと登録できないこと
    it 'first_nameが半角カタカナではなく、全角日本語でないと登録できない' do
      user = build(:user, first_name: "takeshi")
      user.valid?
      expect(user.errors[:first_name]).to include("は日本語で入力して下さい。")
    end
  end
end
