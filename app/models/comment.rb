class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :parent, :class_name => 'Comment', :foreign_key => 'parent_id'
  has_many :parent, :class_name => 'Comment', :foreign_key => 'parent_id',  :dependent => :destroy 
  
  def ancestors(hash={})
    self.parent.each do |child|
      puts child.message
      hash[child.id] = child
      if child.parent.present?
        child.ancestors
      end
    end
    return hash
  end
  
end
