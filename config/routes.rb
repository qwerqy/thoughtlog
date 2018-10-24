Rails.application.routes.draw do
  get 'followings/create'
  get 'followings/destroy'
  root 'home#index'
  get 'home/index'
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'
  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'

  resources :user, controller: 'users' do
    post '/follow' => 'users#follow', as: 'follow'
    delete '/unfollow' => 'users#unfollow', as: 'unfollow'
  end
end
