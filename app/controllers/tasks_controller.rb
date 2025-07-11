# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!
  def index
    @tasks = current_user.tasks.by_priority
    @task = current_user.tasks.build # For the new task form
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task created successfully!"
    else
      @tasks = current_user.tasks.by_priority
      render :index, status: :unprocessable_entity
    end
  end

  def show
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    @tasks = current_user.tasks.by_priority
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path, notice: "Task deleted successfully!" }
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :priority, :status, :due_date)
  end
end
