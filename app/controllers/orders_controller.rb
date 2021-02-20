class OrdersController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
  end

  def create
    @order = Order.create(order_params)
    @address = Address.create(address_params)
    binding.pry
  end

  private

  def order_params
    params.permit.merge(user_id: current_user.id, product_id: params[:product_id])
  end

  def address_params
    params.permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(order_id: @order.id)
  end
end
