class HomeController < ApplicationController
  def index
    @projects = Project.includes(:user).all
  end

  def show
    @followings = current_user.following
  end
end
