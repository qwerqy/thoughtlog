require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:title) }

    describe 'link' do
      it 'is valid without a link'
      it 'is valid with a valid format'
      it "is not valid with invalid link format"
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:thoughts) }
    it { should have_many(:likes) }
  end

  describe 'custom methods' do
    describe 'self.get_flickr' do
    end

    describe 'self.show_flickr' do
    end

    describe 'self.get_tumblr' do
    end

    describe 'self.show_tumblr' do
    end
  end
end
