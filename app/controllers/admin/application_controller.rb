module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user
    before_action :authenticate_admin_permission
    layout 'admin'

    private

    def authenticate_user
      redirect_to login_path, notice: 'please login first' unless current_user
    end

    def authenticate_admin_permission
      redirect_to tasks_path, notice: 'You do not have the permission to enter this page' unless current_user.admin?
    end
  end
end
