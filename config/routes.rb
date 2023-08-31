Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  resources :fiendship_requests
  devise_for :users

  resources :users, only: [:edit, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
