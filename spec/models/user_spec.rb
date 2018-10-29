require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do

    it { should have_secure_password }

    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is valid without a first_name" do
      user = build(:user)
      user.first_name = nil
      expect(user).to be_valid
    end

    it "is valid without a last_name" do
      user = build(:user)
      user.last_name = nil
      expect(user).to be_valid
    end

    it "is valid without a location" do
      user = build(:user)
      user.location = nil
      expect(user).to be_valid
    end

    it "is valid without an about" do
      user = build(:user)
      user.about = nil
      expect(user).to be_valid
    end

    it "is valid without an avatar" do
      user = build(:user)
      user.avatar = nil
      expect(user).to be_valid
    end

  # EMAIL

    it "is not valid with invalid email format" do
      user = build(:user)
      user.email = 'abc@example.com..'
      expect(user).to_not be_valid
    end

    it "should have a unique email" do
      user = build(:user)
      User.create!(first_name:'foo', last_name: 'bar', location:'thailand', about:'lorem the ipsum', email: 'johndoe@example.com', password: 'abcd1234')
      expect(user).to_not be_valid
    end

    it "is not valid without an email" do
      user = build(:user)
      user.email = nil
      expect(user).to_not be_valid
    end

  # PASSWORD

    it "is not valid without a password" do
      user = build(:user)
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a minimum of 8 characters password" do
      user = build(:user)
      user.password = 'abc233'
      expect(user).to_not be_valid
    end
  end
  # CUSSTOM METHODS
  describe "custom methods" do
    describe 'name' do
      it "combines first and last name together" do
        user = build(:user)
        full_name = user.name
        expect(full_name).to eq("John Doe")
      end
    end

    describe 'following?' do
      it "should able to return false if user is not following other user" do
        user = create(:user)
        other_user = create(:user, email: 'jonnydoe@example.com')
        expect(user.following?(other_user)).to eq(nil)
      end

      it "should able to return true if user is following other user" do
        user = create(:user)
        other_user = create(:user, email: 'jonnydoe@example.com')
        user.follow!(other_user)
        expect(user.following?(other_user)).to be_valid
      end
    end

    describe 'like?' do
      it "should return project if user likes" do
        user = create(:user)
        other_user = create(:user, email: 'other@example.com')
        project = create(:project, user_id: other_user.id)
        Like.create!(user_id: user.id, project_id: project.id)
        expect(user.like?(project)).to be_valid
      end
    end

    describe 'follow!' do
      it 'should create relationship between user 1 and user 2' do
        user = create(:user)
        other_user = create(:user, email: 'jonnydoe@example.com')
        expect(user.follow!(other_user)).to be_valid
      end
    end

    describe 'unfollow' do
      it 'should unfollow user 1 and user 2' do
        user = create(:user)
        other_user = create(:user, email: 'jonnydoe@example.com')
        user.follow!(other_user)
        expect(user.unfollow!(other_user)).to be_valid
      end
    end
  end

# ASSOCIATION
  describe "association" do
    it { should have_many(:followers) }
    it { should have_many(:following) }
    it { should have_many(:projects) }
    it { should have_many(:thoughts) }
    it { should have_many(:likes) }
    it { should have_many(:authentications) }
    it { should have_many(:inspires) }
    it { should have_many(:ideas) }
  end

end
