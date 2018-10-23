Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  resources :user, controller: 'users'
  resources :session, controller: 'sessions'
end
