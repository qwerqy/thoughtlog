Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  get '/following/projects' => 'home#show', as: 'following_project'
  get '/login' => 'sessions#new', as: 'login'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy', as: 'logout'
  get '/signup' => 'users#new', as: 'signup'
  post '/signup' => 'users#create'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  resources :user, controller: 'users' do
    post '/follow' => 'users#follow', as: 'follow'
    delete '/unfollow' => 'users#unfollow', as: 'unfollow'
    resources :projects, controller: 'projects', only: [:create, :new, :show, :edit, :update, :destroy] do
      resources :thoughts, controller: 'thoughts'
    end
  end

  get '/projects/all' => 'projects#index', as: 'all_projects'
end
