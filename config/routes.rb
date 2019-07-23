Rails.application.routes.draw do
  # get 'sessions/new'
  # root 'users/new'
  resources :tasks do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  # resources :users, only: [:new, :create, :show]
end
