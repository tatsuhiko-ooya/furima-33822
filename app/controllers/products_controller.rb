class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_product, only: [:edit, :show, :update, :destroy]
  before_action :check_created_product_user, only: [:edit, :update, :destroy]
  # before_action :search_product, only: [:index, :search, :show]

  def index
    @products = Product.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def get_category_child
    @category_child_array = Category.find_by(id: "#{params[:id]}", ancestry: nil).children
  end

  def get_category_grandchild
    @category_grandchild_array = Category.find_by(id: params[:id]).children
    # render json: { grandchild_array: @category_grandchild_array}
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
    unless @product.order.nil?
      redirect_to root_path
    end
  end

  def show
    @likes_count = @product.likes.count
    @comment = Comment.new
    @comments = Comment.where(product_id: @product.id).includes(:user)
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

  def search
    @products = @p.result.includes(:category, :user)
    set_category_column
    set_condition_column
    set_delivery_fee_column
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

  def set_category_column
    @category_column = Category.where(ancestry: nil)
  end

  def set_condition_column
    @condition_column = Condition.where.not(id: 1)
  end

  def set_delivery_fee_column
    @delivery_fee_column = DeliveryFee.where.not(id:1)
  end

end
