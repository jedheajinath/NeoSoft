class SiteController < ApplicationController
  before_action :authenticate_user! , :except => [:index]

  def index
    if user_signed_in?
      redirect_to home_path
    end
  end

  def home
    @post = Post.new
    @posts = User.get_all_posts(current_user)
    @users = User.follower_list(current_user)-User.following_list(current_user)
  end   

end
