require 'auth0'

# StaticPagesController - static pages controller.
class StaticPagesController < ApplicationController

  include Auth0::Api::AuthenticationEndpoints
  include Auth0::Mixins::HTTPProxy
  include Auth0::Mixins::Headers

  before_action :set_auth0_vars, only: %i[process_login_ro]

  attr_accessor :client_id, :domain

  def home
    render 'home'
  end

  def lock
    @state = SecureRandom.hex(16)
    @domain = ENV['AUTH0_RUBY_DOMAIN']
    @client_id = ENV['AUTH0_RUBY_CLIENT_ID']
    render 'lock'
  end

  def login_ro
    render 'login_ro'
  end

  def process_login_ro
    login_ro = params[:login_ro]
    # response = auth0_client.login_with_resource_owner(login_ro[:email], login_ro[:password])
    response = login_with_resource_owner(login_ro[:email], login_ro[:password])
    options = Struct.new(:domain, :client_id, :client_secret)
    auth0_jwt = OmniAuth::Auth0::JWTValidator.new(options.new(
      @domain,
      @client_id,
      @client_secret
    ))
    @id_token = auth0_jwt.decode(response.id_token)
    render 'login_ro'
  rescue => e
    @error = "#{e.class.name}: #{e.message}"
    render 'login_ro'
  end

  private

  def set_auth0_vars
    @domain = ENV['AUTH0_RUBY_DOMAIN']
    @client_id = ENV['AUTH0_RUBY_CLIENT_ID']
    @client_secret = ENV['AUTH0_RUBY_CLIENT_SECRET']
    @base_uri = "https://#{@domain}"
    @headers = client_headers
  end
  #
  # def client_headers
  #   client_info = JSON.dump(name: 'ruby-auth0', version: Auth0::VERSION)
  #   {
  #     'Content-Type' => 'application/json',
  #     'User-Agent' => "Ruby/#{RUBY_VERSION}",
  #     'Auth0-Client' => Base64.urlsafe_encode64(client_info)
  #   }
  # end
  #
  # # Setup the Auth0 API connection.
  # def auth0_client
  #   @client_id = ENV['AUTH0_RUBY_CLIENT_ID']
  #   @client_secret = ENV['AUTH0_RUBY_CLIENT_SECRET']
  #   @domain = ENV['AUTH0_RUBY_DOMAIN']
  #
  #   @auth0_client ||= Auth0::Client.new(
  #     token: '123',
  #     client_id: @client_id,
  #     client_secret: @client_secret,
  #     domain: @domain
  #   )
  # end
end
