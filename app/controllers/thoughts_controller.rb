class ThoughtsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:project_id])
    @thought = Thought.new(content: params[:thought][:content], project_id: @project.id, user_id: @user.id)
    if @thought.save
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def thought_params
    params.require(:thought).permit(
      :content
    )
  end
end
