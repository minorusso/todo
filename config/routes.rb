Rails.application.routes.draw do
  get '/tasks', to: 'tasks#index'
  get 'tasks/show'
  get 'tasks/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
