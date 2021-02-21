module ApplicationHelper
  def flash_style(type)
    if type == 'notice'
      'alert alert-success'
    else
      'alert alert-danger'
    end
  end
end
