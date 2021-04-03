class CardsController < ApplicationController
  before_action :authenticate_user!


  def new
    if session[:product_id]
      @product = Product.find(session[:product_id])
    end
    @card = Card.new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
   customer = Payjp::Customer.create(
   description: 'test', 
   card: params[:card_token] 
   )

   @card = Card.new( 

    card_token: params[:card_token], 
    customer_token: customer.id, 
    user_id: current_user.id 
   )
   
    if @card.save
      if session[:product_id]
        @product = Product.find(session[:product_id])
        session[:product_id] = nil
        redirect_to product_orders_path(@product)
      else
        redirect_to user_path(current_user)
      end
    else
      render "new"
      
    end
  end
end
