class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      flash[:notice] = "#{@user.errors.full_messages}"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile Updated."
      redirect_back(fallback_location: user_path(@user.id))
    else
      flash[:error] = "Something's wrong. #{@user.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: user_path(@user.id))
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :about,
      :location,
      :avatar,
      :avatar_cache
    )
  end
end
