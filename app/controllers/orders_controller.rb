class OrdersController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      @product = Product.find(params[:product_id])
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(user_id: current_user.id, product_id: params[:product_id])
    # params.permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(user_id: current_user.id, product_id: params[:product_id])

  end

  # def order_params
  #   params.permit.merge(user_id: current_user.id, product_id: params[:product_id])
  # end

  # def address_params
  #   params.permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(order_id: @order.id)
  # end
end
