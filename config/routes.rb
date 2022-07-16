Rails.application.routes.draw do
  api_route = '/api'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    post '/users', to: 'users#create'
    post '/auth', to: 'users#authenticate'
    delete '/auth', to: 'users#logout'
    resources :doctors, only: [:index, :show]
  end

  # delete "#{api_route}/auth", to:'home#logout'
  resources :appointments, path: "#{api_route}/appointments"

  root to: 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
