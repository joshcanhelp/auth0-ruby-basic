require('pp')

# AuthController - handles OmniAuth callback URLs.
class AuthController < ApplicationController
  before_action :userinfo?, only: [:callback]
  before_action :user?, only: [:callback]
  before_action :user_login?, only: [:callback]

  def callback

    # User does not have an existing auth0_id, associate and login!
    if user.auth0_id.nil?
      user.auth0_id = auth0_id
      user.save
      return login_and_redirect user
    end

    # Existing auth0_id does not match, reject!
    login_failed 'User with that Auth0 ID already exists.'
  end

  # Login failed at Auth0
  def failure
    msg_returned = request.params['message']
    login_failed msg_returned.nil? ? 'Auth0 login failed.' : msg_returned
  end

  #
  # START - Private methods
  #
  private

  # This stores all the user information that came from Auth0 and the IdP
  def userinfo?
    @userinfo = session[:userinfo] = request.env['omniauth.auth']

    # No email address, reject
    return login_failed 'Email required.' unless @userinfo['info']['email']

    @email = @userinfo['info']['email']
    @auth0_id = @userinfo['uid']
  end

  # This stores all the user information that came from Auth0 and the IdP
  def user?
    @user = User.find_by(email: @email) if @userinfo

    # No user with that email so create the user with auth0_id.
    return create_user_and_login @userinfo if @user.nil?
  end

  def user_login?
    # Existing auth0_id matches, login!
    return login_and_redirect @user if @user.auth0_id == @auth0_id
  end

  # Create new user from returned userinfo.
  def create_user_and_login(userinfo)
    nickname = userinfo['info']['nickname']
    user = User.new(
      name: nickname.nil? ? userinfo['info']['name'] : nickname,
      email: @email,
      auth0_id: @auth0_id
    )
    user.save
    login_and_redirect user
  end

  # Log a user in and redirect with a success message.
  def login_and_redirect(user)
    log_in user
    flash[:success] = 'Logged in with Auth0!'
    redirect_back_or users_path
  end

  # Redirect a failed login to the homepage with a flash message.
  def login_failed(message)
    flash[:danger] = message
    redirect_to root_path
  end
end
