class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:destroy]

  def create
    @relationship = Relationship.create(relationship_param)
    @users = User.follower_list(current_user)-current_user.following_list
    @posts = current_user.get_all_posts.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    @relationship.destroy
  end
  
  def following
    @users = current_user.following_list
  end

  def follower
    @users = current_user.followed_list
  end

  private

  def set_relationship
    @relationship = Relationship.find(params[:id]) 
  end
  
  def relationship_param
    params.permit(:follower_id,:following_id)
  end
end
