class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:completed].present?
        @tasks = current_user.tasks.search_title(params[:task][:title]).search_completed(params[:task][:completed]).page(params[:page])
      elsif params[:task][:title].present?
        @tasks = current_user.tasks.search_title(params[:task][:title]).page(params[:page])
      elsif params[:task][:completed].present?
        @tasks = current_user.tasks.search_completed(params[:task][:completed]).page(params[:page])
      end
    else
      if params[:sort_expired] == "true"
        @tasks = current_user.tasks.time_limit.page(params[:page])
      elsif params[:sort_priority] == "true"
        @tasks = current_user.tasks.priority.page(params[:page])
      else
        @tasks = current_user.tasks.created_at.page(params[:page])
      end
    end
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :details, :time_limit, :completed, :priority, { label_ids: [] }).merge(user_id:current_user.id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end