class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :posts
  has_many :comments

  # has_many :relationships , foreign_key: :follower_id
  # has_many :reverse_relationships , class_name: :Relationship , foreign_key: :following_id , dependent: :destroy 
  # has_many :followers , through: :relationships , source: :follower 
  # has_many :followings , through: :reverse_relationships , source: :following

  has_many :followers , class_name: :Relationship , source: :follower ,foreign_key: :follower_id
  has_many :followings , class_name: :Relationship , source: :following ,foreign_key: :following_id

  mount_uploader :image, ImageUploader
  scope :follower_list, lambda { |value| where.not('id = (?)', value) if value }
  
  def self.following_list(current_user)
    array=[]
    current_user.followers.each do |f| array += [f.following] end
    return array
  end

  def self.followed_list(current_user)
      array=[]
      current_user.followings.each do |f| array +=[f.follower] end
      return array
  end
  def self.get_all_posts(current_user)
    post=[]
    current_user.followers.each do |f|
      post += f.following.posts
    end 
    return post += current_user.posts
  end

end
