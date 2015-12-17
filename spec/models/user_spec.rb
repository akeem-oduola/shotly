require "rails_helper"

RSpec.describe User, type: :model do
  describe "#create_user_from_omniauth" do
    it "creates users from valid OmniAuth response" do
      user = User.create_user_from_omniauth(set_valid_omniauth)
      expect(user).to be_instance_of User
      expect(User.first).to eq user
    end

    it "does not create users for invalid OmniAuth response" do
      expect(User.create_user_from_omniauth(set_invalid_omniauth)).not_to be_instance_of User
      expect(User.create_user_from_omniauth(set_invalid_omniauth)).to be false
    end
  end

  describe "#top" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "returns the top users" do
      expect(User.top).to include(@user)
    end
  end
end
