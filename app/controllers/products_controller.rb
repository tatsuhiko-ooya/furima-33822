class ProductsController < ApplicationController
  def index
  end

  def new

  end

  def create

  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :days_id, :price, :image)
    .merge(user_id: current_user.id)
  end
end
