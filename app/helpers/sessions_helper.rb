module SessionsHelper

  # Log the current user in.
  def log_in(user)
    session[:user_id] = user.id
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Log out of persistent session.
  def log_out
    current_user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session.delete(:user_id)
    @current_user = nil
  end

  # Is the corrent user logged in?
  def logged_in?
    !current_user.nil?
  end

  # Get the current user or none if not logged in
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Redirects back to a stored location or a default.
  def redirect_back_or(default)
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  # Stores the forwarding URL.
  def store_forwarding_loc
    session[:forwarding_url] = request.original_url if request.get?
  end
end
