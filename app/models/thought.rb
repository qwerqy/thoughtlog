class Thought < ApplicationRecord
  belongs_to :user
  belongs_to :project, counter_cache: :thoughts_count

  validates_presence_of(:content)
end
