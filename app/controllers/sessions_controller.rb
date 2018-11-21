require 'omniauth/auth0/jwt_validator'
require 'auth0'

# SessionsController - login and logout controller.
# Handles the session creation in the app and Auth0 redirects.
class SessionsController < ApplicationController
  before_action :admin?, only: [:create]
  before_action :find_user, only: [:create]
  before_action :auth0_data, only: [:new, :callback]

  # Redirect to OmniAuth login flow.
  def new
    redirect_to '/auth/auth0'
  end

  # Ruby SDK auth flow
  # def new
  #   extend Auth0::Api::AuthenticationEndpoints
  #   options = {
  #     scope: 'openid email offline_access',
  #     state: SecureRandom.hex(16)
  #   }
  #   session[:auth0_state] = options[:state]
  #   redirect_to authorization_url(callback_url, options).to_s
  # end

  # Ryby SDK callback
  # def callback
  #   extend Auth0::Api::AuthenticationEndpoints
  #   extend Auth0::Mixins::HTTPProxy
  #
  #   query_hash = Rack::Utils.parse_nested_query(request.query_string)
  #   raise RuntimeError, 'No state param found' if query_hash['state'].nil?
  #   raise RuntimeError, 'Invalid state' if query_hash['state'] != session[:auth0_state]
  #   raise RuntimeError, 'No auth code param found' if query_hash['code'].nil?
  #
  #   session.delete(:auth0_state)
  #   token = auth_code_exchange(
  #     query_hash['code'],
  #     callback_url,
  #     client_id: @client_id,
  #     client_secret: @client_secret
  #   )
  #
  #   options = Struct.new(:domain, :client_id, :client_secret)
  #   jwt_decode = OmniAuth::Auth0::JWTValidator.new(options.new(
  #     @domain,
  #     @client_id,
  #     @client_secret
  #   ))
  #
  #   abort jwt_decode.decode(token.id_token).inspect
  # end

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
    redirect_to "https://#{ENV['AUTH0_RUBY_DOMAIN']}/v2/logout" +
      "?client_id=#{ENV['AUTH0_RUBY_CLIENT_ID']}" +
      "&returnTo=#{root_url}"
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

  def callback_url
    "#{request.base_url}/auth0-callback"
  end

  def auth0_data
    @domain = ENV['AUTH0_RUBY_DOMAIN']
    @base_uri = "https://#{@domain}"
    @headers = {
      'Content-Type' => 'application/json'
    }
    @client_id = ENV['AUTH0_RUBY_CLIENT_ID']
    @client_secret = ENV['AUTH0_RUBY_CLIENT_SECRET']
  end
end
