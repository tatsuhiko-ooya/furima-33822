class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_product, only: [:edit, :show, :update, :destroy]
  before_action :check_created_product_user, only: [:edit, :update, :destroy]

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

  def edit
  end

  def show
  end

  def update
    @product.update(product_params)
    if @product.save
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def check_created_product_user
    redirect_to root_path unless current_user == @product.user
  end

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id,
                                    :days_id, :price, :image).merge(user_id: current_user.id)
  end
end
