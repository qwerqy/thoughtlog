class HomeController < ApplicationController
  def index
    if signed_in?
      client = Tumblr::Client.new
      @tagged = client.tagged'ideas', limit: 10
      @flickrs = Project.get_flickr('idea')
      @projects = Project.includes(:user).limit(20).order(created_at: :desc)
    end
  end

  def show
    @followings = current_user.following
  end
end
