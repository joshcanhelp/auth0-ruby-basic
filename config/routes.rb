Rails.application.routes.draw do

  # Admin routes for SDK testing
  # Separate to use as examples
  get 'admin/users', to: 'all_users#index'
  get 'admin/rules', to: 'all_rules#index'
  get 'admin/client-grants', to: 'all_client_grants#index'
  get 'admin/connections', to: 'all_connections#index'
  get 'admin/clients', to: 'all_clients#index'

  # Auth0
  namespace 'auth' do
    scope ':provider' do
      get 'callback'
      get 'failure'
    end
  end

  root 'static_pages#home'
  get 'static_pages/home'

  # Login auth routes
  get    '/signup',   to: 'sessions#new'
  get    '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # Users Resource
  resources :users

  # Articles Resource
  resources :articles do

    # Comments Resource
    resources :comments
  end
end
