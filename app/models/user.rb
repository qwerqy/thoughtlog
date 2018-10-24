class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  include BCrypt
  has_secure_password

  validates :first_name, presence: true, if: :first_name
  validates :last_name, presence: true, if: :last_name
  validates :email, presence: true, uniqueness: true, if: :email
  validates :password, presence: true, length: {minimum: 8}, if: :password

  def name
    "#{self.first_name} " + "#{self.last_name}"
  end
end
