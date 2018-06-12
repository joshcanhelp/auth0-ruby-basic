class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if (user && user.authenticate(params[:session][:password]))
      log_in user
      redirect_back_or user
    else
      flash.now[:error] = 'User not found or incorrect password.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'Logged out!';
    redirect_to login_url
  end
end
