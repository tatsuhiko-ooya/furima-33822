class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  def show
    @user_like_products = current_user.like_products
    @user_products = current_user.products
    @user_comment_products = current_user.comment_products
    if current_user.card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
      card = Card.find_by(user_id: current_user.id)
      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
    end
  end

  def edit
    
  end

  def update
    @user.update(user_params)
    if @user.valid?
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  

  private
  def find_user
    @user = User.find(params[:id])
  end

  def check_user
    redirect_to root_path unless current_user == @user
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :last_name, :first_name, :last_name_kana, :first_name_kana)
  end
end
