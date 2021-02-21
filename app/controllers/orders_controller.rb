class OrdersController < ApplicationController
  def index
    @product = Product.find(params[:product_id])
    @order_address = OrderAddress.new
  end

  def create
    @product = Product.find(params[:product_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(user_id: current_user.id, product_id: params[:product_id],token: params[:token])
    # params.permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(user_id: current_user.id, product_id: params[:product_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
        amount: @product.price,
        card: order_params[:token],
        currency: 'jpy'
    )
  end
  # def order_params
  #   params.permit.merge(user_id: current_user.id, product_id: params[:product_id])
  # end

  # def address_params
  #   params.permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(order_id: @order.id)
  # end
end
