class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  include BCrypt
  has_secure_password

  has_many :followers, :class_name => 'Relationship', :foreign_key => 'user_id'
  has_many :following, :class_name => 'Relationship', :foreign_key => 'follower_id'
  has_many :projects, dependent: :destroy
  has_many :thoughts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :inspires, dependent: :destroy
  has_many :ideas, through: :inspires, dependent: :destroy

  validates :first_name, presence: true, if: :first_name
  validates :last_name, presence: true, if: :last_name
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :email
  validates_presence_of :email
  validates :password, presence: true, length: {minimum: 8}, if: :password

  # def check_uniqueness_of_name
  #   if Idea.includes(inspires: :users).where.not(items: {id: self.id}).where(items: {name: self.name}).count > 0
  #     errors.add(:name, 'name was duplidated')
  #   end
  # end

  def self.create_with_auth_and_hash(authentication, auth_hash)
   user = self.create!(
     first_name: auth_hash["info"]["first_name"],
     last_name: auth_hash["info"]["last_name"],
     location: auth_hash["info"]["location"],
     remote_avatar_url: auth_hash["info"]["image"],
     email: auth_hash["info"]["email"],
     password: SecureRandom.hex(10)
   )
   user.authentications << authentication
   return user
  end

  # grab google to access google for user data
  def google_token
   x = self.authentications.find_by(provider: 'google_oauth2')
   return x.token unless x.nil?
  end

  def name
    "#{self.first_name} " + "#{self.last_name}"
  end

  def following?(other_user)
    following.find_by(user_id: other_user.id)
  end

  def like?(project)
    likes.find_by(project_id: project.id)
  end

  def follow!(other_user)
    following.create!(user_id: other_user.id)
  end

  def unfollow!(other_user)
    following.find_by(user_id: other_user.id).destroy
  end
end
