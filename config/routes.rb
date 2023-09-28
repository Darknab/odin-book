Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  
  devise_for :users

  resources :users, only: [:edit, :update, :show] do
    resources :friendship_requests, only: [:create, :index, :update, :destroy]
    resources :friendships, only: [:index, :destroy]
  end

  resources :posts do
    resources :comments do
      resources :replies, except: :index
    end
  end

  resources :likes, only: [:create, :destroy]
 

  # Defines the root path route ("/")
  root "posts#index"
end
