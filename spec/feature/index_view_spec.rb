require "rails_helper"

RSpec.feature "IndexView" do

  before :each do
    @link = FactoryGirl.create(:link)
  end

  describe "Visit home page", type: :feature do
    it "Visits home page" do
      visit "/"
      expect(page).to have_content "Shotly"
    end
  end

  describe "Log In/Log out" do
    it "Logs in with facebook" do
      expect(User.count).to eq 0
      set_valid_omniauth
      visit "/"
      click_on "Please Login with: Facebook"
      expect(User.count).to eq 1
      expect(page).to have_content "My Links"
    end

    it "it does not log in with invalid facebook response" do
      expect(User.count).to eq 0
      set_invalid_omniauth
      visit "/"
      click_on "Please Login with: Facebook"
      expect(User.count).not_to eq 1
      expect(page).not_to have_content "My Links"
    end

    it "Logs out " do
      expect(User.count).to eq 0
      set_valid_omniauth
      visit "/"
      click_on "Please Login with: Facebook"
      expect(User.count).to eq 1
      click_on "Log Out"
      expect(page).to have_content "Please Login with: Facebook"
    end
  end

  describe "Shortens Url if present", js: true do
    it "Shortens long url" do
      visit "/"
      fill_in("link_url", with: "#{FactoryGirl.build(:link)}")
      click_on "Shorten Url"
      expect(page).to have_content "Link was successfully created."
    end

    it "Does not shortens long url if nil" do
      visit "/"
      fill_in("link_url", with: nil)
      click_on "Shorten Url"
      expect(page).to have_content "Url field is empty, please enter information."
    end
   end
end
