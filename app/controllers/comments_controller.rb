class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_product

  def create
    comment = Comment.new(comment_params)
    if comment.save
      ActionCable.server.broadcast 'comment_channel', comment: comment, user: comment.user
    else
      @comments = Comment.where(product_id: @product.id).includes(:user)
      @comment = Comment.new
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
