class CommentsController < ApplicationController
    before_action :authenticate_user!

  def create
    if Comment.create(comment_params)
      redirect_to product_path(@product)
    else
      @comments = Comment.where(product_id: @product.id).includes(:user)
      render 'products/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
  end

  private
    def comment_params
      params.require(:comment).permit(:message).merge(user_id: current_user.id, product_id: params[:product_id])
    end

    def find_product
      @product = Product.find(params[:product_id])
    end

    
end
