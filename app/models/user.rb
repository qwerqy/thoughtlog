class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  include BCrypt
  has_secure_password

  has_many :followers, :class_name => 'Relationship', :foreign_key => 'user_id'
  has_many :following, :class_name => 'Relationship', :foreign_key => 'follower_id'

  validates :first_name, presence: true, if: :first_name
  validates :last_name, presence: true, if: :last_name
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :email
  validates :password, presence: true, length: {minimum: 8}, if: :password

  def name
    "#{self.first_name} " + "#{self.last_name}"
  end

  def following?(other_user)
    following.find_by(user_id: other_user.id)
  end

  def follow!(other_user)
    following.create!(user_id: other_user.id)
  end

  def unfollow!(other_user)
    following.find_by(user_id: other_user.id).destroy
  end
end
