require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    user = described_class.new(
        first_name:'foo',
        last_name: 'bar',
        location:'thailand',
        about:'lorem the ipsum',
        email: 'abc@example.com',
        password: 'abcd1234'
      )

    it { should have_secure_password }

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is valid without a first_name" do
      user.first_name = nil
      expect(user).to be_valid
    end

    it "is valid without a last_name" do
      user.last_name = nil
      expect(user).to be_valid
    end

    it "is valid without a location" do
      user.location = nil
      expect(user).to be_valid
    end

    it "is valid without an about" do
      user.about = nil
      expect(user).to be_valid
    end

    it "is valid without an avatar" do
      user.avatar = nil
      expect(user).to be_valid
    end

  # EMAIL

    it "is not valid with invalid email format" do
      user.email = 'abc@example.com..'
      expect(user).to_not be_valid
    end

    it "should have a unique email" do
      User.create!(first_name:'foo', last_name: 'bar', location:'thailand', about:'lorem the ipsum', email: 'abc@example.com', password: 'abcd1234')
      expect(user).to_not be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

  # PASSWORD

    it "is not valid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a minimum of 8 characters password" do
      user.password = 'abc233'
      expect(user).to_not be_valid
    end
  end

# ASSOCIATION
  describe "association" do
    it { should have_many(:projects) }
    it { should have_many(:thoughts) }
    it { should have_many(:following) }
    it { should have_many(:followers) }
    it { should have_many(:authentications) }
  end
end
