class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index

    # if params[:task].present?
    #   if params[:task][:title].present? && params[:task][:completed].present?
    #     @tasks = current_user.tasks.search_title(params[:task][:title]).search_completed(params[:task][:completed]).page(params[:page])
    #   elsif params[:task][:title].present?
    #     @tasks = current_user.tasks.search_title(params[:task][:title]).page(params[:page])      
    #   elsif params[:task][:completed].present?
    #     @tasks = current_user.tasks.search_completed(params[:task][:completed]).page(params[:page])
    #   elsif params[:task][:label].present?
    #     @tasks = current_user.tasks.search_label(params[:task][:label]).page(params[:page])
    #   else
    #     @tasks = current_user.tasks.select(:id, :title, :content, :created_at,:completed,:priority,:expired_at).order(created_at: :DESC).page(params[:page])
    #   end
    # else
    #   if params[:sort_expired]
    #     @tasks = current_user.tasks.select(:id, :title, :content, :created_at,:completed,:priority,:expired_at).order(expired_at: :ASC).page(params[:page])
    #   elsif params[:sort_priority]
    #     @tasks = current_user.tasks.select(:id, :title, :content, :created_at,:completed,:priority,:expired_at).order(priority: :ASC).page(params[:page])
    #   else
    #     @tasks = current_user.tasks.includes(:labels).all.order(created_at: :DESC).page(params[:page])
    #   end
    # end
    

  

    # if params[:task].present?
    #   if params[:task][:title].present? && params[:task][:completed].present?
    #     @tasks = current_user.tasks.search_title(params[:task][:title]).search_completed(params[:task][:completed]).page(params[:page])
    #   elsif params[:task][:title].present?
    #     @tasks = current_user.tasks.search_title(params[:task][:title]).page(params[:page])
    #   elsif params[:task][:completed].present?
    #     @tasks = current_user.tasks.search_completed(params[:task][:completed]).page(params[:page])
    #   end
    # else
    #   if params[:sort_expired] == "true"
    #     @tasks = current_user.tasks.time_limit.page(params[:page])
    #   elsif params[:sort_priority] == "true"
    #     @tasks = current_user.tasks.priority.page(params[:page])
    #   # elsif
    #   #   @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    #   else
    #     @tasks = current_user.tasks.created_at.page(params[:page])
    #   end
    # end

    if params[:sort_expired]
      @tasks = current_user.tasks.time_limit.page(params[:page])
    elsif params[:sort_priority]
      @tasks = current_user.tasks.priority.page(params[:page])
    elsif params[:task].present?
      if params[:task][:title].present? && params[:task][:completed] == '選択して下さい'
        @tasks = current_user.tasks.search_title(params[:task][:title]).page(params[:page])
      elsif params[:task][:title].present? && params[:task][:completed].present?
        @tasks = current_user.tasks.search_title(params[:task][:title]).search_completed(params[:task][:completed]).page(params[:page])
      elsif params[:task][:label_id].present?
        @labelling = Labelling.where(label_id: params[:task][:label_id]).pluck(:task_id)
        @tasks = current_user.tasks.where(id: @labelling).page(params[:page])       
      elsif params[:task][:completed].present?
        @tasks = current_user.tasks.search_completed(params[:task][:completed]).page(params[:page])
      end
    else 
      @tasks = current_user.tasks.created_at.page(params[:page])
    end

    # @tasks = current_user.tasks.order(id: 'DESC')
    # @tasks = current_user.tasks.order(time_limit: 'DESC') if params[:sort_expired]
    # @tasks = current_user.tasks.order(priority: 'ASC') if params[:sort_priority]
    # # if params[:task].present?
    # if params[:task][:title].present? && params[:task][:completed].present?
    #   @tasks = current_user.tasks.search_title(params[:task][:title]).search_completed(params[:task][:completed]).page(params[:page])
    # elsif params[:task][:title].present?
    #     @tasks = current_user.tasks.search_title(params[:task][:title])
    #   elsif params[:task][:completed].present?
    #     @tasks = current_user.tasks.search_completed(params[:task][:completed])
    #   elsif params[:task][:label_id].present?
    #     biding.pry
    #     @labelling = labellings.where(label_id: params[:task][:label_id]).pluck(:task_id)
    #     @tasks = current_user.tasks.where(id: @labelling).page(params[:page])
        
    #   end
    # # end
    # @tasks = @tasks.page(params[:page]).per(10)

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