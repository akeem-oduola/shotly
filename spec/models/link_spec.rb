require "rails_helper"

RSpec.describe Link, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:link)).to be_valid
  end

  it "is invalid without a url" do
    expect(FactoryGirl.build(:invalid_link)).not_to be_valid
  end

  before :each do
    @link = FactoryGirl.create(:link)
  end
  it "returns popular links" do
    expect(Link.popular).to include(@link)
  end

  it "returns recent links" do
    expect(Link.recent).to include(@link)
  end

end
