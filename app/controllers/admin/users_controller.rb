class Admin::UsersController < ApplicationController
  before_action :login_judgment
  before_action :admin_login_judgment
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  PER = 50

  def index
    @users = User.select(:id, :name, :email, :created_at, :admin).order("id ASC").page(params[:page]).per(PER)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザーを作成しました'
    else
      render 'new'
    end
  end

  def show
    @tasks = @user.tasks
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
  
end
