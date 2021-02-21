class ApplicationController < ActionController::Base
  include ApplicationHelper

  private

  def authenticate_user
    redirect_to login_path, notice: 'please login first' unless current_user
  end
end
