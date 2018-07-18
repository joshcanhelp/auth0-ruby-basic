require 'auth0'

# ClientCredentialsGrant - Perform a client credentials grant.
# Used to test Management API v2
class ClientCredentialsGrant < AdminController
  # Get all users from Auth0 with "auth0" in their email.
  def index
    @params = {
      fields: req_params.fetch('fields', %w[name client_id app_type]),
      include_fields: req_params['include_fields'],
      page: req_params['page'],
      per_page: req_params['per_page']
    }
    @results = auth0_client.clients @params
    @page_title = 'Client Crendentials Grant'
    render 'admin/client_credentials_grant'
  end
end
