module ApplicationHelper
  def flash_style(type)
    if type == 'notice'
      'alert alert-success'
    else
      'alert alert-danger'
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
