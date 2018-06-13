class AuthController < ApplicationController
  def callback

    # This stores all the user information that came from Auth0 and the IdP
    userinfo = session[:userinfo] = request.env['omniauth.auth']

    # No email address, reject
    return login_failed_redirect 'Email required.' if !userinfo[:info][:email]

    # Try to find the user by email.
    user = User.find_by(email: userinfo[:info][:email])

    # No user with that email so create the user with auth0_id.
    return create_user_and_login userinfo if user.nil?

    # Get the userinfo parameters we need.
    auth0_id = userinfo[:uid]

    # User does not have an existing auth0_id, associate and login!
    if user.auth0_id.nil?
      user.auth0_id = auth0_id
      user.save
      return login_and_redirect user
    end

    # Existing auth0_id matches, login!
    return login_and_redirect user if user.auth0_id == auth0_id

    # Existing auth0_id does not match, reject!
    login_failed_redirect 'User with that Auth0 ID already exists.'

  end

  # Login failed at Auth0
  def failure
    login_failed_redirect !request.params['message'].nil? ?
      request.params['message'] :
      'Failed logging in with Auth0.'
  end

  #
  # START - Private methods
  #
  private

    # Create new user from returned userinfo.
    def create_user_and_login userinfo
      user = User.new(
        name: !userinfo[:info][:nickname].nil? ?
          userinfo[:info][:nickname] :
          userinfo[:info][:name],
        email: userinfo[:info][:email],
        auth0_id: userinfo[:uid]
      )
      user.save
      login_and_redirect user
    end

    # Log a user in and redirect with a success message.
    def login_and_redirect user
      log_in user
      flash[:success] = 'Logged in with Auth0!'
      redirect_back_or users_path
    end

    # Redirect a failed login to the homepage with a flash message.
    def login_failed_redirect message
      flash[:danger] = message
      redirect_to root_path
    end
end
