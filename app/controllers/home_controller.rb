class HomeController < ApplicationController
  def index
    client = Tumblr::Client.new
    @tagged = client.tagged'ideas', limit: 10
    @projects = Project.includes(:user).limit(20).order(created_at: :desc)
  end

  def show
    @followings = current_user.following
  end
end
