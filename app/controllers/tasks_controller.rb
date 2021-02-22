class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :find_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.includes(:labels)
                 .where(user: current_user)
                 .search(name: params[:name], status: params[:status], label: params[:label])
                 .order_by(column: params[:column], direction: params[:direction])
                 .page(params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params.merge(user_id: current_user.id))
    if @task.save
      redirect_to task_path(@task), notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :show
    end
  end

  private

  def find_task
    @task = Task.find_by(id: params[:id], user_id: current_user.id)
  end

  def task_params
    params.require(:task).permit(:name, :description, :start_date, :end_date, :priority, :status)
  end
end
