require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:title) }

    describe 'link' do
      it 'is valid without a link' do
        user = create(:user)
        project = user.projects.build(attributes_for :project, link: nil)
        expect(project).to be_valid
      end

      it 'is valid with a valid format' do
        project = build(:project, link: 'https://superman.com')
        expect(project).to_not be_valid
      end

      it "is not valid with invalid link format" do
        project = build(:project, link: 'examplecom')
        expect(project).to_not be_valid
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:thoughts) }
    it { should have_many(:likes) }
  end

  describe 'custom methods' do
    describe 'self.get_flickr' do
      it "should have return an array" do
        get = Project.get_flickr('idea')
        expect(get).to be_an_instance_of(Array)
      end
    end

    describe 'self.show_flickr' do
      it "should return a hash based on params ID" do
        show = Project.show_flickr(43751244480)
        expect(show).to be_an_instance_of(Hash)
      end
    end

    describe 'self.get_tumblr' do
      it "should return an array" do
        get = Project.get_tumblr('idea')
        expect(get).to be_an_instance_of(Array)
      end
    end

    describe 'self.show_tumblr' do
      it "should return a hash based on params ID" do
        show = Project.show_tumblr('best-shower-thoughts', 179540623955)
        expect(show).to be_an_instance_of(Hash)
      end
    end
  end
end
