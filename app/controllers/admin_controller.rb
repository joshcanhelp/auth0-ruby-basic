# app/controllers/all_users_controllers.rb
require 'auth0'

class AdminController < ApplicationController
  before_action :is_admin

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
  def is_admin
    unless current_user_is_admin?
      flash[:danger] = 'Not authorized.'
      redirect_to root_path
    end
  end

  # Whitelist parameters
  def req_params
    params.permit(:fields, :include_fields, :page, :per_page, :strategy)
  end
end
