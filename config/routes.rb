Rails.application.routes.draw do

  # Articles Resource
  resources :articles do
    
    # Comments Resource
    resources :comments
  end

  # Root requests
  root 'welcome#index'
end
