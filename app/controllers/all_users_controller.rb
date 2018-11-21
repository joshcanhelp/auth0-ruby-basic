# app/controllers/all_users_controllers.rb
require 'auth0'

# AllUsersController - admin URLs to get all Users
# Used to test Management API v2
class AllUsersController < AdminController

  # Get all users from Auth0 with "auth0" in their email.
  def index
    @params = {
      fields: 'email,user_id,user_metadata',
      page: 0,
      per_page: 20,
      # q: "updated_at:{2016-01-01 TO *}",
      q: 'updated_at:[2016-01-01 TO *]',
      search_engine: 'v3' # or 'v2'
    }
    @results = auth0_client.users @params
    @page_title = 'Users'
    render 'admin/users_results'
  end

  # Update a user on Auth0
  def update
    user = params[:auth0_user]
    raise ArgumentError if user[:user_metadata_id].nil?
    metadata = user[:user_metadata].blank? ? {} : JSON.parse(user[:user_metadata])
    auth0_client.update_user(user[:user_metadata_id], {user_metadata: metadata})
    redirect_to admin_users_url
  end
end
