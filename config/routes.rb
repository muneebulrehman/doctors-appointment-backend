Rails.application.routes.draw do
  namespace :api do
    post '/signup', to: 'users#create'
    post '/login', to: 'users#login'
    resources :doctors, only: [:index, :show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
