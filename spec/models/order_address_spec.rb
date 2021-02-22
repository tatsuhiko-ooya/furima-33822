require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe 'create' do
    before do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product)
      #mysqlの負荷エラーが発生するため記述しています
      sleep(0.1)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, product_id: @product.id)
    end

    context '保存できる場合' do
      it 'すべての項目を正しく入力すると新規登録できる' do
        expect(@order_address).to be_valid
      end
    end
    context '保存できない場合' do
      it 'post_codeが空だと新規登録できない' do
        @order_address.post_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeが"-"を含む数字7桁以外だと新規登録できない' do
        @order_address.post_code = "1234567"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end

      it 'post_codeの"-"の位置が数字3桁の後に記述していないと新規登録できない(123-4567)' do
        @order_address.post_code = "1234-456"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code is invalid")
      end

      it 'cityが空だと新規登録できない' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'phone_numberが空だと新規登録できない' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが数字11桁以上だと新規登録できない' do
        @order_address.phone_number = "1234567891234"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが"-"を含んでいると新規登録できない' do
        @order_address.phone_number = "123ー4567ー8912"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが全角だと新規登録できない' do
        @order_address.phone_number = "１２３４５６７８９"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'blockが空だと新規登録できない' do
        @order_address.block = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Block can't be blank")
      end

      it 'tokenが空だと新規登録できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'prefecture_idが1だと新規登録できない' do
        @order_address.prefecture_id = "1"
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it '@order_addressに紐づくuser_idが空と新規登録できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it '@order_addressに紐づくproduct_idが空と新規登録できない' do
        @order_address.product_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Product can't be blank")
      end

      
    end
  end
end
