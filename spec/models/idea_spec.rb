require 'rails_helper'

RSpec.describe Idea, type: :model do
  describe 'associations' do
    it { should have_many(:inspires) }
    it { should have_many(:users) }
  end
end
