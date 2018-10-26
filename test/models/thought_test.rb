require 'rails_helper'

RSpec.describe Thought, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:content) }
  end

  describe 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end
end
