class Relationship < ApplicationRecord
  belongs_to :user, counter_cache: :followings_count
  belongs_to :follower, class_name: "User", counter_cache: :followers_count
end
