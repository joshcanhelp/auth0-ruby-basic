require 'auth0'

class Auth0Controller < ApplicationController
  before_action :set_api
  before_action :is_admin, only: [:clients, :connections, :users]

  def clients
    @params = {
      fields: req_params.fetch('fields', 'name,client_id,app_type'),
      include_fields: req_params.fetch('include_fields', nil),
      page: req_params.fetch('page', nil),
      per_page: req_params.fetch('per_page', nil)
    }
    @clients = @auth0.clients @params
  end

  def connections
    @params = {
      strategy: req_params.fetch('strategy', nil),
      fields: req_params.fetch('fields', 'name,id,strategy'),
      include_fields: req_params.fetch('include_fields', true),
      page: req_params.fetch('page', nil),
      per_page: req_params.fetch('per_page', nil)
    }
    @connections = @auth0.connections @params
  end

  #
  # START - Private methods
  #
  private

    # Require User params, whitelist incoming
    def req_params
      params.permit(:fields, :include_fields, :page, :per_page, :strategy)
    end

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

    # Make sure we have an admin.
    def is_admin
      unless current_user_is_admin?
        flash[:danger] = 'Not authorized.'
        redirect_to root_path
      end
    end
end
