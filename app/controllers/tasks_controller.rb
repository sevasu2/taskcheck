class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # 一覧表示
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true)
  end

  # 詳細画面
  def show
  end

  # 新規登録
  def new
    @task = Task.new
  end

  # 新規作成
  def create
    @task = Task.new(task_params)
    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      redirect_to @task, notice: "タスク「#{task.name}を登録しました。」"
    else
      render :new
    end
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  # 編集画面
  def edit
  end

  # 更新
  def update
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}を更新しました。」"
  end

  # 削除
  def destroy
    task.destroy
    redirect_to tasks_url, notice: "タスクを「#{task.name}」を削除しました。"
  end


  private

  # ストロングパラメーター
  def task_params
    params.require(:task).permit(:name, :description, :image)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
