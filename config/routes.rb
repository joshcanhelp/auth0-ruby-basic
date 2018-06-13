Rails.application.routes.draw do

  # Auth0
  namespace 'auth' do
    scope ':provider' do
      get 'callback'
      get 'failure'
    end
  end

  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'

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
