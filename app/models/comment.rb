class Comment < ActiveRecord::Base
  #has_many :parent, :class_name => 'Comment', :foreign_key => 'parent_id',  dependent: :destroy
  belongs_to :post
  has_closure_tree
  
  def get_child_comment
  	
  end

  def get_uname
     User.find(self.user_id).email
  end

  def parent_comment
  	Comment.where(parent_id=nil).where(self.id=parent_id)
  end

  # def self.get_ancestors(who)
  #   @tree ||= []
  #   if who.parent.nil?
  #     return @tree
  #   else
  #     @tree << who.parent
  #     get_ancestors(who.parent)
  #   end
  # end

  # def ancestors
  #   @ancestors ||= Comment.get_ancestors(self)
  # end


end
