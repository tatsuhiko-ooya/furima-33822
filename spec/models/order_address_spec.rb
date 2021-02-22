require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe 'create' do
    before do
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, product_id: @product.id)
    end

    context '保存できる場合' do
      it 'すべての項目を正しく入力すると商品を購入できる' do
        binding.pry
        expect(@order_address).to be_valid
      end
    end
  end
end
