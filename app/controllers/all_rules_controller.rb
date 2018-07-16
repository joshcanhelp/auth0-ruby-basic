# app/controllers/all_rules_controllers.rb
require 'auth0'

# AllRulesController - admin URLs to get all Rules
# Used to test Management API v2
class AllRulesController < AdminController
  # Get all users from Auth0 with "auth0" in their email.
  def index
    @params = {
      enabled: false
    }
    @results = auth0_client.rules @params
    @page_title = 'Rules'
    render 'admin/api_results'
  end
end
