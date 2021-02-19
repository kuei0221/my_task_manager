module TaskHelper

  def switch_current_direction(column)
    if params[:column] == column && params[:direction] == 'asc'
      'desc'
    else
      'asc'
    end
  end
end
