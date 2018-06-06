Rails.application.routes.draw do

  # Users Resource
  resources :users

  # Articles Resource
  resources :articles do

    # Comments Resource
    resources :comments
  end

  # Root requests
  root 'welcome#index'
end
