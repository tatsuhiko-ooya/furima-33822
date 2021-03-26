class CardsController < ApplicationController
  def new
    @product = Product.find(session[:product_id])
    @card = Card.new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
   customer = Payjp::Customer.create(
   description: 'test', 
   card: params[:card_token] 
   )

   card = Card.new( 
    card_token: params[:card_token], 
    customer_token: customer.id, 
    user_id: current_user.id 
  )
    if card.save
      @product = Product.find(session[:product_id])
      session[:product_id] = nil
      redirect_to product_orders_path(@product)
    else
      redirect_to new_product_card(params[:product_id])
    end
  end
end
