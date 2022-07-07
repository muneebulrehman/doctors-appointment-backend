Rails.application.routes.draw do
  devise_for :users
  namespace :v1 do
    get 'users/create'
    get 'users/update'
    get 'users/destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
