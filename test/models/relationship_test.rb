require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "association" do
    it { should belong_to(:user) }
    it { should belong_to(:follower) }
  end
end
