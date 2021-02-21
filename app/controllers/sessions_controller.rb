class SessionsController < ApplicationController
  def new
    redirect_to tasks_path if current_user
  end

  def create
    @user = User.find_by(name: params[:name])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: t('.login_success')
    else
      flash.now[:alert] = @user ? t('.password_mismatch') : t('.user_not_find')
      render :new
    end
  end

  def destroy
    logout if current_user
    redirect_to login_path, notice: t('.success')
  end

  private

  def logout
    session.delete :user_id
    @current_user = nil
  end
end
