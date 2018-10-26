class Inspire < ApplicationRecord
  belongs_to :user, counter_cache: :inspires_count
  belongs_to :idea, counter_cache: :inspires_count

  validates :idea_id, uniqueness: { scope: :user, message: 'User can only like once' }
end
