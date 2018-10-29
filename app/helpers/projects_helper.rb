module ProjectsHelper
  def inspire_button_flickr(user, project)
    if current_user.ideas.find_by(link: project[:link]).nil?
      link_to flickr_idea_inspire_path(@user, @photo_id), method:'POST', remote: true, class:'ui teal button like-button' do
        '<i class="star icon"></i> Inspire'.html_safe
      end
    else
      link_to flickr_idea_inspire_path(@user, @photo_id), method:'POST', remote: true, class:'ui teal button disabled like-button' do
        '<i class="star icon"></i> Inspired!'.html_safe
      end
    end
  end

  def inspire_button_tumblr(project)
    if current_user.ideas.find_by(link: project['posts'][0]['short_url']).nil?
      link_to tumblr_idea_inspire_path(project['blog']['name'], project['posts'][0]['id']), method:'POST', remote: true, class:'ui teal button like-button' do
        '<i class="star icon"></i> Inspire'.html_safe
      end
    else
      link_to tumblr_idea_inspire_path(project['blog']['name'], project['posts'][0]['id']), method:'POST', remote: true, class:'ui teal button disabled like-button' do
        '<i class="star icon"></i> Inspired!'.html_safe
      end
    end
  end

  def show_project_photo(project)
    s = "<div class='image' style='margin:1em;'>".html_safe
    e = "</div>".html_safe
    if @project.photo.present?
      s + image_tag(@project.photo_url, class:'ui image rounded') + e
    end
  end

  def like_button(user, project)
     if current_user.id != user.id
       if current_user.like?(project)
         render 'likes/unlike'
       else
         render 'likes/like'
       end
     end
  end

  def timeline(project)
    if project.thoughts.present?
      render 'thoughts/timeline'
    else
      render 'thoughts/no_thoughts'
    end
  end

  def new_thought(user)
    if current_user.id == user.id
      render 'thoughts/forms/new'
    end
  end
end
