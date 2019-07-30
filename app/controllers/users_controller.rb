class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_last_user_delete_judge, only: [:update]

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
      # redirect_to user_path(@user.id)
      redirect_to tasks_path
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

  # adminの機能
  def update
  end

  # adminの機能
  def destroy
    user_admin = User.where(admin: true)
    if @user.admin.blank?
      @user.destroy
      redirect_to admin_users_path, notice: 'ユーザーを削除しました'
    else
      if user_admin.size > 1
        @user.destroy
        redirect_to admin_users_path, notice: 'ユーザーを削除しました'
      else
        redirect_to admin_users_path, notice: '管理者ユーザー不在を防止するため、削除できませんでした。'
      end
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

  def update_user
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザー情報を編集しました！'
    else
      render 'admin/users/edit'
    end
  end

  def admin_last_user_delete_judge
    if user_params[:admin] == "false"
      if User.where(admin: true).size > 1
        update_user
      else
        flash.now[:alert] = "管理者ユーザー不在を防止するため、編集できませんでした。"
        render 'admin/users/edit'
      end
    else
      update_user
    end
  end

end
