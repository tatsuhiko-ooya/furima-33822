class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product
  def index
    unless current_user.card.present?
      session[:product_id] = @product.id
      redirect_to new_card_path and return
    end
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    card = Card.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
    if current_user.shipping_address.present?
      insert_order_address
    else
      @order_address = OrderAddress.new
    end
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      if params[:order_address][:default_address] == "true"
        if current_user.shipping_address.present?
          @shipping_address = ShippingAddress.find_by(user_id: current_user.id)
          @shipping_address.update(shipping_address_params)
        else
          @shipping_address = ShippingAddress.create(shipping_address_params)
        end
      end
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

  def shipping_address_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :building, :phone_number, :block).merge(user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
        amount: @product.price,
        customer: customer_token,
        currency: 'jpy'
    )
  end

  def insert_order_address
    @order_address = OrderAddress.new
    @order_address.prefecture_id = current_user.shipping_address.prefecture_id
    @order_address.post_code = current_user.shipping_address.post_code
    @order_address.city = current_user.shipping_address.city
    @order_address.phone_number = current_user.shipping_address.phone_number
    @order_address.block = current_user.shipping_address.block
  end

end
