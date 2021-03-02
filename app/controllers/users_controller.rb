class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :find_user, only: [:show, :edit, :update]
  before_action :check_user, only: [:edit, :update]

  def show

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
