class LikesController < ApplicationController
  before_action :find_product
  before_action :authenticate_user!

  def create
    like = Like.create(user_id: current_user.id, product_id: @product.id)
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end
end
