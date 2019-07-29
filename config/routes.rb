Rails.application.routes.draw do
  # Admin routes for SDK testing
  # Separate to use as examples
  get 'admin/users', to: 'all_users#index'
  post 'admin/users', to: 'all_users#update'
  get 'admin/rules', to: 'all_rules#index'
  get 'admin/client-grants', to: 'all_client_grants#index'
  get 'admin/connections', to: 'all_connections#index'
  get 'admin/clients', to: 'all_clients#index'

  root 'static_pages#home'
  get '/lock', to: 'static_pages#lock'

  get '/login-ro', to: 'static_pages#login_ro'
  post '/login-ro', to: 'static_pages#process_login_ro'

  # Login auth routes
  get    '/signup', to: 'sessions#new'
  get    '/login', to: 'sessions#new'
  get    '/auth0-callback', to: 'sessions#callback'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Users Resource
  resources :users

  # Articles Resource
  resources :articles do
    # Comments Resource
    resources :comments
  end
end
