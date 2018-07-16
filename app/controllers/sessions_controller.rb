# SessionsController - login and logout controller.
# Handles the session creation in the app and Auth0 redirects.
class SessionsController < ApplicationController
  before_action :admin?, only: [:create]
  before_action :find_user, only: [:create]

  def new
    redirect_to '/auth/auth0'
  end

  def create
    if !user || !user.authenticate(params[:session][:password])
      flash.now[:error] = 'User not found or incorrect password.'
      render 'new'
    end
    login
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'Logged out!'
    # redirect_to auth0_logout_url
    redirect_to root_path
  end

  private

  def admin?
    return if current_user_is_admin?
    redirect_to '/login'
  end

  def find_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end

  def login
    log_in user
    redirect_back_or user
  end
end
