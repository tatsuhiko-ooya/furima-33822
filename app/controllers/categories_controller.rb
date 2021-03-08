class CategoriesController < ApplicationController
    before_action :find_category, only: :show
  def index
    @categories = Category.where(ancestry: nil)
  end

  def show
    @products = @category.set_items
    @products = @products.order("created_at DESC")
  end

  private
  def find_category
    @category = Category.find(params[:id])
  end
end
