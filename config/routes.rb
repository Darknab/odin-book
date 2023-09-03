Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  
  devise_for :users

  resources :users, only: [:edit, :update, :show] do
    resources :friendship_requests, only: [:create, :index, :update, :destroy]
    resources :friendships, only: [:index, :destroy ]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
