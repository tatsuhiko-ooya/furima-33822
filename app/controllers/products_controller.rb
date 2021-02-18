class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @products = Product.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :days_id, :price, :image).merge(user_id: current_user.id)
  end
end
