class SessionsController < ApplicationController
  before_action :set_api, only: [:destroy]

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
    # redirect_to @auth0.logout_url(root_url).to_s
    redirect_to root_url
  end

  #
  # START - Private methods
  #
  private

    #
    # START - Before filters
    #

    # Setup the Auth0 API connection.
    def set_api
      @auth0 = Auth0Client.new(
        client_id: ENV['AUTH0_RUBY_CLIENT_ID'],
        client_secret: ENV['AUTH0_RUBY_CLIENT_SECRET'],
        token: ENV['AUTH0_RUBY_API_TOKEN'],
        domain: ENV['AUTH0_RUBY_DOMAIN'],
        api_version: 2
      )
    end
end
