class ApplicationController < ActionController::Base
  include UsersHelper
  def require_login
    unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_path # halts request cycle
    end
  end
end
