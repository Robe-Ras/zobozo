Rails.application.routes.draw do
  get 'city/show' 
  get 'users/index'
  root "welcome#index"
  get 'welcome/index', to: 'welcome#index'
  post '/', to: 'welcome#index_post'
  get 'contact/index'
  get 'team/index'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'

  resources :sessions, only: [:new, :create, :destroy]
  resources :gossips do
    resources :comments
  end # Routes RESTful pour les gossips
  resources :users, only: [:new, :create, :show] # Routes RESTful pour les utilisateurs
  resources :cities
  

  
  get "up" => "rails/health#show", as: :rails_health_check

  
end


