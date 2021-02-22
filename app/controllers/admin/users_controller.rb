module Admin
  class UsersController < ApplicationController
    before_action :find_user, only: %i[edit update destroy]

    def index
      @users = User.page params[:page]
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_pararms)
      if @user.save
        redirect_to admin_users_path, notice: t('.success')
      else
        flash.now[:alert] = t('.fail')
        render :new
      end
    end

    def edit; end

    def update
      if @user.update(user_pararms)
        redirect_to admin_users_path, notice: t('.success')
      else
        flash.now[:alert] = t('.fail')
        render :edit
      end
    end

    def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: t('.success')
      else
        flash.now[:alert] = t('.fail')
        render :index
      end
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_pararms
      params.require(:admin_user).permit(:name, :password, :admin)
    end
  end
end
