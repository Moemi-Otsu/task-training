class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"
  protect_from_forgery with: :exception
  include SessionsHelper

  def login_judgment
    redirect_to new_session_path, notice: 'ログインしてください。' unless current_user
  end

end