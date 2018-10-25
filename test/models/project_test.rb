require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of(:title) }

  it "is not valid with invalid link format" do
    project = described_class.new(link: 'aaaa.com' )
    expect(project).to_not be_valid
  end

  it { should belong_to(:user) }
  it { should have_many(:thoughts) }
end
