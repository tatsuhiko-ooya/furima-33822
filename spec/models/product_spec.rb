require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'create' do
    before do
      @category = FactoryBot.create(:category)
      @product = FactoryBot.build(:product, category_id: @category.id)
    end

    context '保存できる場合' do
      it 'すべての項目を正しく入力すると新規登録できる' do
        binding.pry
        expect(@product).to be_valid
      end
    end

    context '保存できない場合' do
      it 'nameが空だと新規登録できない' do
        @product.name = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it 'descriptionが空だと新規登録できない' do
        @product.description = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Description can't be blank")
      end

      it 'category_idが空だと新規登録できない' do
        @product.category_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end


      it 'condition_idが空だと新規登録できない' do
        @product.condition_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Condition can't be blank")
      end

      it 'condition_idが1だと新規登録できない' do
        @product.condition_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Condition must be other than 1')
      end

      it 'days_idが空だと新規登録できない' do
        @product.days_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Days can't be blank")
      end

      it 'days_idが1だと新規登録できない' do
        @product.days_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Days must be other than 1')
      end

      it 'delivery_fee_idが空だと新規登録できない' do
        @product.delivery_fee_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Delivery fee can't be blank")
      end

      it 'delivery_fee_idが1だと新規登録できない' do
        @product.delivery_fee_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Delivery fee must be other than 1')
      end

      it 'prefecture_idが空だと新規登録できない' do
        @product.prefecture_id = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'prefecture_idが1だと新規登録できない' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it '商品画像が空だと新規登録できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end

      it 'priceが空だと新規登録できない' do
        @product.price = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角数字だと新規登録できない' do
        @product.price = 'さんびゃくえん'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが299以下だと新規登録できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be greater than 299')
      end

      it 'priceが10000000以上だと新規登録できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include('Price must be less than 10000000')
      end

      it 'priceが半角英数字混合だと新規登録できない' do
        @product.price = 'abc123'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが半角英字だと新規登録できない' do
        @product.price = 'abcdef'
        @product.valid?
        expect(@product.errors.full_messages).to include('Price is not a number')
      end

      it '@productに紐づくuserが存在しない場合、新規登録できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include('User must exist')
      end
    end
  end
end
