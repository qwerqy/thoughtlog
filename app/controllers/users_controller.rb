class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy, :follow, :unfollow]
  include UsersHelper
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path
    else
      flash[:negative] = "#{@user.errors.full_messages}"
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
      flash[:positive] = "Profile Updated."
      redirect_back(fallback_location: user_path(@user.id))
    else
      flash[:negative] = "Something's wrong. #{@user.errors.full_messages.to_sentence}"
      redirect_back(fallback_location: user_path(@user.id))
    end
  end

  def follow
    @user = User.find(params[:user_id])
    current_user.follow!(@user)
    redirect_back(fallback_location: @user)
  end

  def unfollow
    @user = User.find(params[:user_id])
    current_user.unfollow!(@user)
    redirect_back(fallback_location: @user)
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
      :avatar_cache,
      :remote_avatar_url
    )
  end
end
