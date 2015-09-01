class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit,:update,:destroy]

  def destroy
    @post.destroy
   @posts = User.get_all_posts(current_user)
  end

  def create
    @post = Post.create(post_params)
    @posts = User.get_all_posts(current_user)
  end

  def update
    @post.update_attributes(post_params)
    @posts = User.get_all_posts(current_user)
  end

  private  
    
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :user_id)
    end
end
