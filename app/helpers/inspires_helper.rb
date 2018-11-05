module InspiresHelper
  def tumblr_photo(url)
    if url.present?
      return photo = url[0]['original_size']['url']
    else
      return photo = ''
    end
  end

  def tumblr_caption(project)
    if project['posts'][0]['caption'].present?
      description = project['posts'][0]['caption']
    else
      description = project['posts'][0]['body']
    end
  end
end
