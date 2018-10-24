class HomeController < ApplicationController
  def index
    @projects = Project.includes(:user).all
  end
end
