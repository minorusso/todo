Rails.application.routes.draw do
  root to: 'users#new'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
    namespace :admin do
      resources :users
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
