class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit,:update,:destroy]

  def create
    @post = Post.new(post_params)
    @post.save
    @posts = current_user.get_all_posts.paginate(page: params[:page], per_page: 3) 
    
  end

  def update
    @post.update_attributes(post_params)
    @posts = current_user.get_all_posts.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    @post.destroy
    @posts = current_user.get_all_posts.paginate(page: params[:page], per_page: 3)
  end

  private  
    
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :user_id)
    end
end
