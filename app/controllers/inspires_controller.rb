class InspiresController < ApplicationController
  def tumblr_create
    client = Tumblr::Client.new
    project = client.posts "#{params[:blog_name]}.tumblr.com", :id => params[:id]

    if project['posts'][0]['photos'].present?
      photo = project['posts'][0]['photos'][0]['original_size']['url']
    else
      photo = ''
    end

    if project['posts'][0]['caption'].present?
      description = project['posts'][0]['caption']
    else
      description = project['posts'][0]['body']
    end

    idea = {
      title: project['blog']['title'],
      description: description,
      photo: photo,
      link: project['posts'][0]['short_url'],
    }
    i = Idea.create!(idea)
    Inspire.create!(idea_id: i.id, user_id: current_user.id)
    respond_to do |format|
      format.js
    end
  end

  def flickr_create
    @user = params[:user_name]
    @photo_id = params[:id]
    @project = Project.show_flickr(@photo_id)

    idea = {
      title: @project[:title],
      description: '',
      photo: @project[:photo],
      link: @project[:link],
    }
    i = Idea.create!(idea)
    Inspire.create!(idea_id: i.id, user_id: current_user.id)
    respond_to do |format|
      format.js
    end
  end
end
