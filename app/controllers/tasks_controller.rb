class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy, :update, :edit, :show]
  
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page])
  end

  def show
    #@task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'タスクが正常に投稿されました。'
      redirect_to @task
      #redirect_to root_url
    else
      flash.now[:danger] = 'タスクが投稿されませんでした。'
      render :new
      #render 'toppages/index'
    end
  end

  def edit
    #@task = Task.find(params[:id])
  end

  def update
    #@task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    #@task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    #redirect_to tasks_url
    redirect_to root_url
    #redirect_back(fallback_location: root_path)
  end
  
  private
  def set_task
    @task = Task.find(params[:id])
  end
  
   # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_path
      #redirect_to @task
    end
  end
  
end
