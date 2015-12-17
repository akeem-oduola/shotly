require "rails_helper"

RSpec.feature "DashboardView" do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe "Create user's links", js: true do
    it "creates a link with user_id" do
      set_valid_omniauth
      fill_in("link_url", with: "#{FactoryGirl.build(:link)}")
      click_on "Shorten Url"
      @link = @user.links.first
      expect(page).to have_content "Link was successfully created."
      expect(@link.user_id).to eq(@user.id)
    end
  end

  it "does not redirect an inactive link", js: true do
    set_valid_omniauth
    visit "/"
    click_on "Please Login with: Facebook"
    click_link "Edit", @link
    uncheck "link_active"
    click_on "Update Link"
    get :redirect_link, path: @link.short_url
    expect(response).not_to redirect_to @link.url
  end
end
