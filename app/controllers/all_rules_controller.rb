# app/controllers/all_users_controllers.rb
require 'auth0'

class AllRulesController < AdminController

  # Get all users from Auth0 with "auth0" in their email.
  def index
    @params = {
      enabled: false
    }
    @results = auth0_client.rules @params
    @page_title = 'Rules'
    render "admin/api_results"
  end
end
