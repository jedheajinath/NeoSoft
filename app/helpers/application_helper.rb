module ApplicationHelper

  def user_stat(name,count)
    raw("#{name}&nbsp;&nbsp;<i class='fa fa-comment'></i><span class='badge'>#{count}</span>")
  end
end
