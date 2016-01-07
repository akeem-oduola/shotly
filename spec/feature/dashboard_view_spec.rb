require "rails_helper"

RSpec.feature "DashboardView" do
  before do
    @user = FactoryGirl.create(:user)
    set_valid_omniauth
  end

  describe "Create user's links", js: true do
    it "creates a link with user_id" do
      visit "/"
      click_on "Please Login with: Facebook"
      fill_in("link[url]", with: "#{FactoryGirl.build(:link)}")
      click_on "Shorten Url"
      @link = @user.links.first
      expect(page).to have_content "Link was successfully created."
      expect(@link.user_id).to eq(@user.id)
      click_on "Edit", @link
      uncheck "link_active"
      click_on "Update Link"
      expect(page).to have_content "My Links"
    end
  end
end
