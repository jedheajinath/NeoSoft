class SiteController < ApplicationController
  before_action :authenticate_user! , :except => [:index]

  # Disply and ask user for login if he is already loggedin redirect to home page 
  def index
    if user_signed_in?
      redirect_to home_path
    end
  end

  # After login display Home Page for user and display all post of user whom he follows
  #  and list of user for follow
  def home
    @post = Post.new
    @posts = current_user.get_all_posts.paginate(page: params[:page], per_page: 3)
    @users = User.follower_list(current_user) - current_user.following_list
  end   
end
