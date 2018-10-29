class HomeController < ApplicationController
  before_action :require_login, only: [:show]
  def index
    if signed_in?
      @tagged = Project.get_tumblr('idea')
      @flickrs = Project.get_flickr('idea')
      @projects = Project.includes(:user).limit(20).order(created_at: :desc)
    end
  end

  def show
    @followings = current_user.following
  end
end
