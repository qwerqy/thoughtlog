require 'rails_helper'

RSpec.describe Inspire, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:idea) }
  end
end
