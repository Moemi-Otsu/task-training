class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
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
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
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
    user_admin = User.where(admin: true)
    # require 'byebug'; byebug
    if user_admin.size >= 1 && @user.admin.blank?
      @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました'
    else
      redirect_to admin_users_path, notice: '管理者ユーザー不在を防止するため、削除できませんでした。'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def user_not_logged_in
    unless current_user.id == @user.id
      redirect_to new_session_path
    end
  end

end
