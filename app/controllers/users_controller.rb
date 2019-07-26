class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    # ログインしている時は、ユーザー登録画面（new画面）に行かせない
    if session[:user_id].present?
      redirect_to new_session_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      # redirect_to tasks_path
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    # @user = User.find(params[:id])
    user_not_logged_in
  end

  def edit
    user_not_logged_in
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザー情報を編集しました！'
    else
      render 'admin/users/edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_not_logged_in
    unless current_user.id == @user.id
      redirect_to new_session_path
    end
  end

end
