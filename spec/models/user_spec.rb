require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'すべての項目を正しく入力するとユーザー新規登録できる' do
      expect(@user).to be_valid
    end

    it 'nicknameが空だと新規登録できない' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空だと新規登録できない' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it '同じemailがすでに存在していると新規登録できない' do
      @user.save
      user1 = FactoryBot.build(:user, email: @user.email)
      user1.valid?
      expect(user1.errors.full_messages).to include("Email has already been taken")
    end

    it 'emailに@が含まれていなければ新規登録できない' do
      @user.email = "testtest"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'passwordが空だと新規登録できない' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下だと新規登録できない' do
      @user.password = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'passwordとpassword_confirmationが同じ値でなければ新規登録できない' do
      @user.password = "testpassword"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'last_nameが空だと新規登録できない' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'last_nameが全角以外だと新規登録できない' do
      @user.last_name = "test"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name 平仮名、全角カタカナ、漢字のみ使用可能です。")
    end

    it 'first_nameが空だと新規登録できない' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'first_nameが全角以外だと新規登録できない' do
      @user.first_name = "test"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name 平仮名、全角カタカナ、漢字のみ使用可能です。")
    end

    it 'last_name_kanaが空だと新規登録できない' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'last_name_kanaが全角以外だと新規登録できない' do
      @user.last_name_kana = "てすと"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana 全角カタカナのみ使用可能です。")
    end

    it 'first_name_kanaが空だと新規登録できない' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'first_name_kanaが全角以外だと新規登録できない' do
      @user.first_name_kana = "てすと"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana 全角カタカナのみ使用可能です。")
    end

    it 'birth_dayが空だと新規登録できない' do
      @user.birth_day = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth day can't be blank")
    end


  end
end
