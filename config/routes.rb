Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'
  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'

  resources :user, controller: 'users'
end
