class SessionsController < ApplicationController
  def new
    redirect_to '/auth/auth0'
  end

  def create
    return redirect_to '/auth/auth0' if !current_user_is_admin?

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
    redirect_to root_path
  end
end
