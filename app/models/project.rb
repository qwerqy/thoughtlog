class Project < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user

  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :link, format: { with: URL_REGEXP, message: 'You provided invalid URL' }, unless: :leave_empty?

  private

  def leave_empty?
    link == ''
  end
end
