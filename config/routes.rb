Rails.application.routes.draw do

  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get  '/signup',  to: 'users#signup'

  # Users Resource
  resources :users

  # Articles Resource
  resources :articles do

    # Comments Resource
    resources :comments
  end
end
