# app/controllers/all_users_controllers.rb
require 'auth0'

class AllUsersController < ApplicationController

  # Get all users from Auth0 with "auth0" in their email.
  def index
    @params = {
      q: "email:*auth0*",
      fields: 'email,user_id,name',
      include_fields: true,
      page: 0,
      per_page: 50
    }
    @users = auth0_client.users @params
  end

  private

  # before_action: Setup the Auth0 API connection.
  def auth0_client
    @auth0_client ||= Auth0Client.new(
      client_id: ENV['AUTH0_RUBY_CLIENT_ID'],
      token: ENV['AUTH0_RUBY_API_TOKEN'],
      domain: ENV['AUTH0_RUBY_DOMAIN'],
      api_version: 2,
      timeout: 15 # optional, defaults to 10
    )
  end
end
