class TasksController < ApplicationController
  before_action :set_task, only: %i[  edit update destroy ]
  def index
    @tasks = Task.all 
    @task = Task.new
  end
  def edit;  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.json { render :index, status: :ok, location: @task }
        format.html { redirect_to tasks_path(@task), notice: "Task was successfully created." }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render :index, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path(@task), notice: "Task was successfully updated." }
        format.json { render :index, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end