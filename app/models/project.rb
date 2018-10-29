class Project < ApplicationRecord
  include Elasticsearch::Model unless Rails.env.test?
  include Elasticsearch::Model::Callbacks unless Rails.env.test?

  unless Rails.env.test?
    settings do
      mappings dynamic: false do
        indexes :user, type: :text
        indexes :title, type: :text, analyzer: :english
        indexes :description, type: :text, analyzer: :english
        indexes :link, type: :text
      end
    end
  end

  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :thoughts, dependent: :destroy
  has_many :likes, dependent: :destroy

  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :link, format: { with: URL_REGEXP, message: 'You provided invalid URL' }, unless: :leave_empty?
  validates_presence_of(:title)

  def self.get_flickr(params)
    flickr = FlickRaw::Flickr.new ENV['FLICKRAW_API_KEY'], ENV['FLICKRAW_SHARED_SECRET']
    @photos = flickr.photos.search tags: params, privacy_filter: 1, per_page: 10
    array = Array.new
    @photos.photo.compact!
    @photos.photo.each do |i|
      if i.present?
        x = flickr.photos.getSizes photo_id: i.id
        image = x.find { |s| s.label == 'Medium'}
        user = flickr.profile.getProfile user_id: i.owner

        if user.respond_to?(:first_name)
          name = "#{user.first_name} " + "#{user.last_name}"
        else
          name = 'Flickr User'
        end

        if image.present?
          photo = image.source
          link = image.url
        else
          photo = ''
          link = ''
        end

        photo = {
          title: i.title,
          photo: photo,
          photo_id: i.id,
          link: link,
          user: name
        }
        array << photo
      end
    end
    return array
  end

  def self.show_flickr(id)
    flickr = FlickRaw::Flickr.new ENV['FLICKRAW_API_KEY'], ENV['FLICKRAW_SHARED_SECRET']
    sizes = flickr.photos.getSizes photo_id: id
    info = flickr.photos.getInfo photo_id: id
    image = sizes.find { |s| s.label == 'Medium'}
    show = {
      title: info.title,
      photo: image.source,
      link: image.url,
      user: info.owner.username
    }
    return show
  end

  def self.get_tumblr(params)
    client = Tumblr::Client.new
    a = client.tagged"#{params}", limit: 10
    return a
  end

  def self.show_tumblr(blog_name, id)
    client = Tumblr::Client.new
    project = client.posts "#{blog_name}", :id => id
    return project
  end


  private

  def leave_empty?
    link == nil
  end
end
