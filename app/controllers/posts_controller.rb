class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit,:update,:destroy]

  def destroy
    @post.destroy
    @posts = Post.all
  end

  def create
    @post = Post.create(post_params)
    @posts = Post.all
  end

  def update
    @post.update_attributes(post_params)
    @posts = Post.all
  end

  private  
    
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :user_id)
    end
end
