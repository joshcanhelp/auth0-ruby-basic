# app/controllers/all_users_controllers.rb
require 'auth0'

# AdminController - extendable class for admin URLs.
# Used to test Management API v2
class AdminController < ApplicationController
  before_action :admin?

  private

  # Set the Auth0 API client
  def auth0_client
    @auth0_client ||= Auth0Client.new(
      client_id: ENV['AUTH0_RUBY_CLIENT_ID'],
      token: ENV['AUTH0_RUBY_API_TOKEN'],
      domain: ENV['AUTH0_RUBY_DOMAIN'],
      api_version: 2,
      timeout: 15 # optional, defaults to 10
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