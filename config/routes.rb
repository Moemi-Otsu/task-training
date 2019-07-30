Rails.application.routes.draw do
  root to: 'users#new'

  namespace :admin do
    resources :users
  end
  resources :tasks do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
