module HomeHelper
  def landing
    if signed_in?
      render 'home/index/home'
    else
      render 'home/index/landing'
    end
  end

  def project_owner_name(project)
    link_to user_path(project.user.id) do
      '<i class="user icon"></i>'.html_safe
      project.user.name
    end
  end

  def project_photo(project)
    if project.photo_url.present?
    f = '<div class="image">'.html_safe
    b = '</div>'.html_safe
    return f + image_tag(project.photo_url) + b
    end
  end

  def project_thoughts(project)
    if project.thoughts.present?
      f = '<div class="meta">'.html_safe
      b = '</div>'.html_safe
      return f + project.thoughts.count + " thoughts." + b
    end
  end

  def followed_user_projects_exists?(followings)
    d = []
    followings.each do |follow|
      if follow.user.projects.any?
        d << true
      else
        d << false
      end
    end
    
    if d.include?(true)
      render 'home/show/cards'
    elsif d.all? == false
      "<h4 class='ui grey center aligned header'>Looks like people you followed haven't posted any projects.</h4>".html_safe
    end
  end
end
