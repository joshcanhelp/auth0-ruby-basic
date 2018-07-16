# app/controllers/all_users_controllers.rb
require 'auth0'

# AllUsersController - admin URLs to get all Users
# Used to test Management API v2
class AllUsersController < AdminController
  # Get all users from Auth0 with "auth0" in their email.
  def index
    @params = {
      fields: 'email,user_id,name',
      page: 0,
      per_page: 20,
      # q: "updated_at:{2016-01-01 TO *}",
      q: 'updated_at:[2016-01-01 TO *]',
      search_engine: 'v3' # or 'v2'
    }
    @results = auth0_client.users @params
    @page_title = 'Users'
    render 'admin/api_results'
  end
end
