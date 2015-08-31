class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:destroy]

  def create
    @relationship=Relationship.create(relationship_param)
    @users = User.follower_list(current_user)-User.following_list(current_user)
  end

  def destroy
    @relationship.destroy
    #@users = User.following_list(current_user)
  end
  
  def followers
    @users = User.following_list(current_user)
  end

  private

  def set_relationship
    @relationship=Relationship.find(params[:id]) 
  end
  
  def relationship_param
    params.permit(:follower_id,:following_id)
  end
end
