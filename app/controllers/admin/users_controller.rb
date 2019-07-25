class Admin::UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    # ログインしている時は、ユーザー登録画面（new画面）に行かせない
    # if session[:user_id].present?
    #   redirect_to new_session_path
    # else
      @user = User.new
    # end
  end

  private

  # def set_user
  #   @user = User.find(params[:id])
  # end
  
end
