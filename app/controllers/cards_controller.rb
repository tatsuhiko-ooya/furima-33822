class CardsController < ApplicationController
  before_action :authenticate_user!


  def new
    if session[:product_id]
      @product = Product.find(session[:product_id])
    end
    @card = Card.new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    customer = Payjp::Customer.create(
    description: 'test', 
    card: params[:card_token] 
    )
    create_new_card(customer)
   
    if @card.save
      checked_has_session_id
    else
      render "new"
    end
  end

  private
  def checked_has_session_id
    if session[:product_id]
      # sessionがある場合、商品購入ページへリダイレクトする
      @product = Product.find(session[:product_id])
      session[:product_id] = nil
      redirect_to product_orders_path(@product)
    else
      # sessionがない場合、ユーザーのマイページへリダイレクトする
      redirect_to user_path(current_user)
    end
  end

  def create_new_card(customer)
    @card = Card.new( 
      card_token: params[:card_token], 
      customer_token: customer.id, 
      user_id: current_user.id 
    )
  end
end
