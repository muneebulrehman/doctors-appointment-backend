Rails.application.routes.draw do
  namespace :api do
    # get 'users/create'
    # get 'users/update'
    # get 'users/destroy'
    post '/users', to: 'users#create'
    post '/auth', to: 'users#authenticate'
    resources :doctors, only: [:index, :show]
  end

  resources :appointments, path: '/api/appointments'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
