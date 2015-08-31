class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]
  
  def new
    if params[:id].present? 
      @post=Post.find(params[:id])
      @comment=@post.comments.build
      @comments=@post.comments
    end
  end

  def create
    @comment = Comment.create(comment_params)
    @comments = @comment.get_root_comment.comments
  end

  def update
    @comment.update_attributes(comment_params)
    @comments = @comment.get_root_comment.comments
  end

  def destroy
    @comment.destroy
    @comments = @comment.get_root_comment.comments
  end

  def ancestors
    comment = Comment.find(params[:id])
    @comment = comment.parents.build
    @comments = @comment.get_root_comment.comments
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end
    
    def comment_params
      params.require(:comment).permit(:message, :post_id, :user_id, :parent_id)
    end
end
