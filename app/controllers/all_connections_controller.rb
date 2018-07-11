# app/controllers/all_users_controllers.rb
require 'auth0'

class AllConnectionsController < AdminController

  # Get all users from Auth0 with "auth0" in their email.
  def index
    @params = {
      strategy: req_params['strategy'],
      fields: req_params.fetch('fields', ['name', 'id', 'strategy']),
      include_fields: req_params['include_fields'],
      page: req_params['page'],
      per_page: req_params['per_page']
    }
    @results = auth0_client.connections @params
    @page_title = 'Connections'
    render "admin/api_results"
  end
end
