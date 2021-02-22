class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product
  def index
    @order_address = OrderAddress.new
  end

  def create
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

  def find_product
    @product = Product.find(params[:product_id])
    if @product.user == current_user || @product.order.present?
        redirect_to root_path
    end
  end

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(user_id: current_user.id, product_id: params[:product_id],token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
        amount: @product.price,
        card: order_params[:token],
        currency: 'jpy'
    )
  end

end
