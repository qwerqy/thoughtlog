module UsersHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  def signed_in?
    current_user.present?
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def following?(user)
    current_user.following.include?(user)
  end

  def account_settings(user)
    if Authentication.find_by(user_id: user.id).present?
      '<h5 class="ui header grey">
        We have detected that you signed in via your Google Account. You may continue signing in via Google, without having to worry about changing your account details here.
        Have a good day!
      </h5>'.html_safe
    else
       render 'users/form_account_setting'
    end
  end

  def display_name(user)
    if @user.first_name
      @user.name
    else
      @user.email
    end
  end

  def user_profile(user)
    if current_user.id == user.id
      link_to( "Edit Profile", edit_user_path(user.id), class: 'ui teal button', style:"margin-top:1em;margin-bottom:1em;") +
      link_to( "Add Project", new_user_project_path(user.id), class: 'ui teal button', style:"margin-top:1em;margin-bottom:1em;")
    else
      if current_user.following?(user)
        link_to "Unfollow", user_unfollow_path(user.id), method: 'delete', class: 'ui teal button', style:"margin-top:1em;margin-bottom:1em;"
      else
        link_to "Follow", user_follow_path(user.id), method: 'post', class: 'ui teal button', style:"margin-top:1em;margin-bottom:1em;"
      end
    end
  end

  def projects_tab(user)
    if user.id == current_user.id 
       render 'users/user_projects_tab'
    else
       render 'users/projects_tab'
    end
  end
end
