class SiteController < ApplicationController
   
	def create_post
        post = Post.new(:content => params[:content], :user_id => params[:user_id])
        if post.save
	        render :json => { :post => post, :status=> "Created" , :auther => current_user.email }
	    else
	      render :json => { :post => post.error, :status=> "Error" }
	    end
	end

	def delete_post
	   post=Post.find(params[:id])
	   if post.destroy
	   	  render :json => { :status => "Deleted" }
	   else
	   	  render :json => { :status => "Delered" }
	   end
	end

	def delete_comment
		comment=Comment.find(params[:id])
		if comment.destroy
			render :json => {:status => "Comment Deleted"}
		else
			render :json => {:status => "Error"}
		end
	end
	
	
	def index
		if user_signed_in?
           redirect_to home_path
        end
	end

	def home
		if user_signed_in?
	 	@post=Post.new
	 	@posts=Post.all
	 	@comment=Comment.new
        else
        	redirect_to new_user_session_path
        end
	 	#@posts=User.includes(:posts)#.where.not("posts.user_id=?", current_user.id)
	    # @posts= User.joins("RIGHT JOIN posts ON users.id = posts.user_id").limit(1)

	end
	def comment
        if params[:message].present?
		   comment=Comment.new
           comment.message=params[:message]
           comment.post_id=params[:post_id]
           comment.user_id=params[:user_id]
           if comment.save
           	  format.html { redirect_to home_path, notice: 'Comment was successfully created.' }
		    else
			        render :json=> {:status => "not inserted"}
		    end
	      end
	end

	def create
     render :json=> {:status => "true"}
   end

    private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :user_id)
    end
   
end
