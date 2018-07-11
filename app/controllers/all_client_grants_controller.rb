# app/controllers/all_users_controllers.rb
require 'auth0'

class AllClientGrantsController < AdminController

  # Get all users from Auth0 with "auth0" in their email.
  def index
    @params = {
      page: 0,
      per_page: 2,
    }
    @results = auth0_client.client_grants @params
    @page_title = 'Client Grants'
    render "admin/api_results"
  end
end
