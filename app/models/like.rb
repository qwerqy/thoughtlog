class Like < ApplicationRecord
  belongs_to :project, counter_cache: :likes_count
  belongs_to :user, counter_cache: :likes_count

  validates :project_id, uniqueness: { scope: :user_id, message: 'User can only like once' }
end
