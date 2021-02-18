module TaskHelper

  def current_created_sort
    if params[:created_sort] && params[:created_sort] == 'asc'
      'desc'
    else
      'asc'
    end
  end
end
