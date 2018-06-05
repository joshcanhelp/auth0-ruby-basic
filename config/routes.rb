Rails.application.routes.draw do

  # Articles Resource
  resources :articles

  # Root requests
  root 'welcome#index'
end
