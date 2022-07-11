Rails.application.routes.draw do
  namespace :api do
    # get 'users/create'
    # get 'users/update'
    # get 'users/destroy'
    post '/users', to: 'users#create'
    post '/auth', to: 'users#authenticate'
    resources :appointments
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
