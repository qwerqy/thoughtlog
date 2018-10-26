class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @like = Like.create!(user_id: current_user.id, project_id: @project.id)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @like = @project.likes.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.js
    end
  end
end
