class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
   
    def get_uname
      User.find(self.user_id).email
    end
     
    def get_c_uname(uid)
      User.find(uid).email
    end
    def get_comment
       self.comments.all.order("created_at").where("parent_id is null")
    end

    # def getobject(post)
    # 	if post.new_record?  
    # 	else
    #        post=Post.new 
    # 	end
    # end

    # def getcomment
    # 	Post.where("parent_id=?", self.id) 
    # end 

    # def getcommentedpost(id)
    #     post=Post.find("id=?",id)
    #     if post.count == 0 
    #     	return 0;
    #     else
    #     	return post;
    #     end
    # end
end
