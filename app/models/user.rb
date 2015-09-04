 class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :posts, dependent:  :destroy
  has_many :comments, dependent:  :destroy
  has_many :followers, class_name: :Relationship, source: :follower,
    foreign_key: :follower_id, dependent:  :destroy
  has_many :followings, class_name: :Relationship, source: :following,
    foreign_key: :following_id, dependent:  :destroy
  #
  has_one :profile, dependent:  :destroy

  # has_many :assets, dependent: :destroy
  # accepts_nested_attributes_for :assets, allow_destroy: :true

  mount_uploader :image, ImageUploader
  scope :follower_list, proc {|value| where.not('id = (?)', value) if value }
  
  def following_list
    array = []
    self.followers.each do |f| array += [f.following] end
    return array
  end

  def followed_list
      array=[]
      self.followings.each do |f| array += [f.follower] end
      return array
  end

  def get_all_posts
    post = []
    self.followers.each do |f|
      post += f.following.posts
    end
    post += self.posts
    return post.sort_by {|post| post[:created_at] }.reverse
  end

end
