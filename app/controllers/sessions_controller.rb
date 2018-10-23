class SessionsController < ApplicationController
  include UsersHelper
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      sign_in(@user)
      redirect_to root_path
    else
      flash[:notice] = "#{@user.errors.full_messages}"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
