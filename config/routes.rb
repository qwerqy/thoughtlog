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
    patch '/update-email' => 'users#update_email', as: 'update_email'
    patch '/update-password' => 'users#update_password', as: 'update_password'
    resources :projects, controller: 'projects', only: [:create, :new, :show, :edit, :update, :destroy] do
      resources :thoughts, controller: 'thoughts'
      resources :likes, controller: 'likes', only: [:create, :destroy]
    end
    get '/inspired-project/:id/new' => 'projects#new_inspired_projects', as: 'inspired_project'
    delete '/inspired-project/:id/delete' => 'projects#destroy_inspired_projects', as: 'remove_inspired_project'
  end

  get '/projects/all' => 'projects#index', as: 'all_projects'
  get '/projects/:blog_name/:id' => 'projects#tumblr_show', as: 'tumblr'
  get '/projects/flickr/:user_name/:id' => 'projects#flickr_show', as: 'flickr'
  post '/projects/:blog_name/:id/inspire' => 'inspires#tumblr_create', as: 'tumblr_idea_inspire'
  post '/projects/flickr/:user_name/:id/inspire' => 'inspires#flickr_create', as: 'flickr_idea_inspire'
  get '/:user_id/projects/user' => 'projects#user_projects', as: 'self_projects'
  get '/:user_id/projects/saved' => 'projects#liked_projects', as: 'liked_projects'
  get '/:user_id/ideas/inspired' => 'projects#inspired_ideas', as: 'inspired_ideas'
end
