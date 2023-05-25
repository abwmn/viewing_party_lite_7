# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'
  get '/logout', to: 'users#logout'
  get '/dashboard', to: 'users#show'

  resources :users, only: [:new, :create] do
    member do
      get 'discover'
      resources :movies, only: [:index, :show] do
        resources :parties, only: [:new, :create], path: 'viewing-party'
      end
    end
  end
end
