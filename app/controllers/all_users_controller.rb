# app/controllers/all_users_controllers.rb
require 'auth0'

class AllUsersController < AdminController

  # Get all users from Auth0 with "auth0" in their email.
  def index
    @params = {
      fields: 'email,user_id,name',
      include_fields: true,
      page: 0,
      per_page: 20,
      # q: "updated_at:{2016-01-01 TO *}",
      # search_engine: 'v2'
      q: "updated_at:[2016-01-01 TO *]",
      search_engine: 'v3'
    }
    @results = auth0_client.users @params
    @page_title = 'Users'
    render "admin/api_results"
  end
end
