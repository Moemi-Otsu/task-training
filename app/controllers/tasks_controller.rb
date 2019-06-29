class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      Task.create(task_params)
      redirect_to new_task_path
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :content)
  end

end
