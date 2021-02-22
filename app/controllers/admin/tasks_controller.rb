module Admin
  class TasksController < ApplicationController
    def index
      @tasks = Task.page params[:page]
      render template: 'tasks/index'
    end
  end
end