class TasksController < ApplicationController
  before_action :login_judgment
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  # ページ送りのTask数を設定
  PER = 10

  def index
    # 終了期限順にソート
    if params[:sort] == "true"
      @tasks = Task.all.order("deadline DESC").page(params[:page]).per(PER)
    elsif params[:title_search] == "" && params[:status_search] == "" && params[:priority_search] == "" && params[:btn_search]
      redirect_to tasks_path, notice: '絞り込み条件を入力してください。'
    elsif params[:title_search].present? && params[:status_search].present? && params[:priority_search].present? && params[:btn_search] 
      @tasks = Task.title_search_ambiguous(params[:title_search]).status_search_param(params[:status_search]).priority_search_param(params[:priority_search]).page(params[:page]).per(PER)
      # タイトルが検索ヒットしなければアラートをだす
      no_match
    elsif params[:title_search].present? && params[:status_search].present? && params[:btn_search]
      @tasks = Task.title_search_ambiguous(params[:title_search]).status_search_param(params[:status_search]).page(params[:page]).per(PER)
      # @tasks = Task.where("title LIKE?", "%#{params[:title_search]}%").where(status: params[:status_search])
      no_match
    elsif params[:title_search].present? && params[:priority_search].present? && params[:btn_search]
      @tasks = Task.title_search_ambiguous(params[:title_search]).priority_search_param(params[:priority_search]).page(params[:page]).per(PER)
      no_match
    elsif params[:status_search].present? && params[:priority_search].present? && params[:btn_search]
      @tasks = Task.status_search_param(params[:status_search]).priority_search_param(params[:priority_search]).page(params[:page]).per(PER)
      no_match
    elsif params[:title_search].present?
      # LIKEによるタイトルのあいまい検索
      @tasks = Task.title_search_ambiguous(params[:title_search]).page(params[:page]).per(PER)
      no_match
    elsif params[:status_search].present?
      # @tasks = Task.where(status: params[:status_search])
      @tasks = Task.status_search_param(params[:status_search]).page(params[:page]).per(PER)
      no_match
    elsif params[:priority_search].present?
      @tasks = Task.priority_search_param(params[:priority_search]).page(params[:page]).per(PER)
      no_match
    else
      @tasks = Task.all.order("created_at DESC").page(params[:page]).per(PER)
    end
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクを作成しました'
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを更新しました"
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました'
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  # 絞り込み - 条件にマッチしない時にアラート
  def no_match
    if @tasks.count == 0
      redirect_to tasks_path, notice: '絞り込み条件にマッチするタスクはありません。'
    end
  end

end
