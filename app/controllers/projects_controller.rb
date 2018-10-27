class ProjectsController < ApplicationController
  before_action :require_login, only: [:show, :edit, :new, :create, :update, :destroy, :follow, :unfollow]
  def index
  end

  def show
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    @like = @project.likes.find_by(user_id: current_user.id)
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
      flash[:negative] = "Something's wrong. #{@project.errors.full_messages.to_sentence}"
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
    client = Tumblr::Client.new
    @project = client.posts "#{params[:blog_name]}.tumblr.com", :id => params[:id]
  end

  def flickr_show
    @user = params[:user_name]
    @photo_id = params[:id]
    @project = Project.show_flickr(@photo_id)
  end

  def user_projects
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.js
    end
  end

  def liked_projects
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.js
    end
  end

  def inspired_ideas
    @user = User.find(params[:user_id])
    respond_to do |format|
      format.js
    end
  end

  def new_inspired_projects
    @user = User.find(params[:user_id])
    @idea = Idea.find(params[:id])
  end

  def destroy_inspired_projects
    @user = User.find(params[:user_id])
    @idea = Idea.find(params[:id])
    @idea.destroy
    respond_to do |format|
      format.js
    end
  end

  def search
    query = params[:search_projects].presence && params[:search_projects][:query]

    if query
      client = Tumblr::Client.new
      @tagged = client.tagged query, limit: 10
      @flickrs = Project.get_flickr(query)
      @projects = Project.search(query)
      @count = @projects.size + @flickrs.size + @tagged.size
    end
  end

  private

  def project_params
    params.require(:project).permit(
      :title,
      :description,
      :link,
      :photo,
      :remote_photo_url
    )
  end
end
