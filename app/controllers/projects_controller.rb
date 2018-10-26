class ProjectsController < ApplicationController
  before_action :require_login, only: [:show, :edit, :new, :create, :update, :destroy, :follow, :unfollow]
  def index
  end

  def show
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.build(project_params)
    if @project.save
      redirect_to @user
    else
      flash[:error] = "Something's wrong. #{@project.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: @user)
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    @project.update(project_params)
    redirect_to @user
  end

  def destroy
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    @project.destroy
    redirect_back(fallback_location: @user)
  end

  def tumblr_show
    client = Tumblr::Client.new consumer_key: ENV['TUMBLR_KEY']
    @project = client.posts "#{params[:blog_name]}.tumblr.com", :id => params[:id]
  end

  private

  def project_params
    params.require(:project).permit(
      :title,
      :description,
      :link,
      :photo
    )
  end
end
