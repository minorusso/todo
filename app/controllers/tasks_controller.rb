class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:completed].present?
        @tasks = Task.where('title LIKE ?', "%#{params[:task][:title]}%").where(completed: "#{params[:task][:completed]}")
      elsif params[:task][:title].present?
        @tasks = Task.where('title LIKE ?', "%#{params[:task][:title]}%")
      elsif params[:task][:completed].present?
        @tasks = Task.where(completed: "#{params[:task][:completed]}")
      end
    else
      if params[:sort_expired] == "true"
        @tasks = Task.all.order(time_limit: :desc)
      elsif
        @tasks = Task.all.order(created_at: :desc)
      end
    end
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "ブログ作成しました!"
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました!"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました!"
  end

  private
  def task_params
    params.require(:task).permit(:title, :details, :time_limit, :completed)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end