require "rails_helper"

RSpec.describe PagesController, type: :controller do
  before :each do
    @user = FactoryGirl.create(:user)
    @link = FactoryGirl.create(:link)
    @popular = Link.popular.limit(5)
    @recent = Link.recent.limit(5)
    @top = User.top.limit(5)
  end

  describe "GET index" do
    it "displays popular links" do
      get :index, link: @link
      expect(@popular).to include(@link)
    end

    it "displays recent links" do
      get :index, link: @link
      expect(@recent).to include(@link)
    end
  end

  describe "GET dashboard" do
    it "displays user links when logged in" do
      get :dashboard, { id: @link.id }, user_id: @user.id
      expect(response).to render_template(:dashboard)
    end

    it "does not displays user links when logged out" do
      get :dashboard, id: @link.id
      expect(response).to redirect_to root_path
    end
  end
end
