# app/controllers/all_users_controllers.rb
require 'auth0'

# AdminController - extendable class for admin URLs.
# Used to test Management API v2
class AdminController < ApplicationController
  before_action :admin?

  private

  # Set the Auth0 API client
  def auth0_client
    @client_id = ENV['AUTH0_RUBY_CLIENT_ID']
    @client_secret = ENV['AUTH0_RUBY_CLIENT_SECRET']
    @domain = ENV['AUTH0_RUBY_DOMAIN']

    @auth0_client ||= Auth0::Client.new(
      # token: ENV['AUTH0_RUBY_API_TOKEN'],
      # access_token: ENV['AUTH0_RUBY_API_TOKEN'],
      client_id: @client_id,
      client_secret: @client_secret,
      domain: @domain,
      api_version: 2,
      timeout: 15
    )
  end

  # Make sure we have an admin.
  def admin?
    return if current_user_is_admin?
    flash[:danger] = 'Not authorized.'
    redirect_to root_path
  end

  # Whitelist parameters
  def req_params
    params.permit(:fields, :include_fields, :page, :per_page, :strategy)
  end
end
