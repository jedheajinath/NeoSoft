module SiteHelper

  def edit_url
    raw("<i class='fa fa-pencil-square-o'></i>")
  end

  def delete_url
    raw("<i class='fa fa-trash-o'></i>")
  end

  def comment_url(comment_count)
    raw("<i class='fa fa-comment'></i><span class='badge'>#{comment_count}</span>")
  end

  def ancestors_url(comment)
    "/comments/ancestors/#{comment.id}"
  end

  def new_comment_url(comment)
  	"/comments/new/#{comment}"
  end
  
end
