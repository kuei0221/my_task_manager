class TaskLabelsController < ApplicationController
  before_action :authenticate_user

  def new
    @label = Label.new
    @available_labels = Label.where(user: current_user).not_label_to_task(params[:id])
  end

  def create
    @label = Label.find_or_initialize_by(name: label_params[:name], user: current_user)
    @label.tasks << Task.find(params[:id])

    if @label.save
      redirect_to task_path(params[:id]), notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
  end

  def destroy
    @task_label = TaskLabel.find_by(task_id: params[:id], label_id: params[:label_id])

    if @task_label&.destroy
      redirect_back fallback_location: tasks_path, notice: 'success'
    else
      redirect_back fallback_location: tasks_path, alert: 'fail'
    end
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
