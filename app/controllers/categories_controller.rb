class CategoriesController < ApplicationController
    before_action :find_category, only: :show
  def index
    @categories = Category.where.not(id: 1)
  end

  def show
    @products = @category.products
  end

  private
  def find_category
    @category = Category.find(params[:id])
  end
end
