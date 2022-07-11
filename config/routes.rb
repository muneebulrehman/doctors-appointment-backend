Rails.application.routes.draw do
  namespace :api do
    # get 'users/create'
    # get 'users/update'
    # get 'users/destroy'
    # resources :users, only: :create
    post '/signup', to: 'users#create'
    post '/login', to: 'users#login'
    get '/logout', to: 'users#logout'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
