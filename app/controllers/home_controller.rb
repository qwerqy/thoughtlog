class HomeController < ApplicationController
  def index
    client = Tumblr::Client.new consumer_key: ENV['TUMBLR_KEY']
    @tagged = client.tagged'ideas', limit: 10
    @projects = Project.includes(:user).limit(20).order(created_at: :desc)
    respond_to do |format|
      format.html
      format.json { render json: @tagged }
    end
  end

  def show
    @followings = current_user.following
  end
end
