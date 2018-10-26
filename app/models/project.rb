class Project < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  has_many :thoughts, dependent: :destroy
  has_many :likes, dependent: :destroy

  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :link, format: { with: URL_REGEXP, message: 'You provided invalid URL' }, unless: :leave_empty?
  validates_presence_of(:title)

  def self.get_flickr(params)
    flickr = FlickRaw::Flickr.new ENV['FLICKRAW_API_KEY'], ENV['FLICKRAW_SHARED_SECRET']
    @photos = flickr.photos.search tags: params, privacy_filter: 1, per_page: 20
    array = Array.new
    @photos.photo.compact!
    @photos.photo.each do |i|
      if i.present?
        x = flickr.photos.getSizes photo_id: i.id

        image = x.find { |s| s.label == 'Medium'}

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
          link: link,
          user: ''
        }
        array << photo
      end
    end
    return array
  end

  private

  def leave_empty?
    link == ''
  end
end
