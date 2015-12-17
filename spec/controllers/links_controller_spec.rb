require "rails_helper"

RSpec.describe LinksController, :type => :controller do
  subject(:links) { Link.new(url: url, user_id: current_user.id)}
  let(:current_user){set_valid_omniauth}
  let(:url){"https://github.com/andela-aadepoju/Fly/blob/master/app/controllers/bookings_controller.rb"}
  before do
    @link = Link.create(url: url)
  end
  describe "GET show" do
    it "displays link details" do
      get :show, id: @link.id
      expect(:links).not_to be nil
    end

    it "redirects to root_path because user is not logged in" do
      get :show, id: @link.id
      expect(response).to redirect_to(root_path)
    end

    before do
      @user = FactoryGirl.create(:user)
    end

    it "displays details page as user is logged in" do
      get :show, {id: @link.id}, user_id: @user.id
      expect(response).to render_template(:show)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new link" do
        expect{
          post :create, link: FactoryGirl.attributes_for(:link)
        }.to change(Link,:count).by(1)
      end

      it "redirects to root_path when not logged in upon save" do
        post :create, link: FactoryGirl.attributes_for(:link)
        expect(response).to redirect_to root_url
      end

      before do
       @user = FactoryGirl.create(:user)
      end

      it "redirects to dashboard when logged in upon save" do
        post :create, { link: FactoryGirl.attributes_for(:link) }, user_id: @user.id
        expect(response).to redirect_to dashboard_url
      end
    end

    context "with invalid attributes" do
      it "does not save the new link" do
        expect{
          post :create, link: FactoryGirl.attributes_for(:invalid_link)
        }.to_not change(Link, :count)
      end
      before do
        @request.env["HTTP_REFERER"] = "http://test.com/pages/dashboard"
      end

      it "re-renders the current page" do
        post :create, link: FactoryGirl.attributes_for(:invalid_link)
        expect(response).to redirect_to :back
      end
    end
  end

  describe "PATCH update" do
    before do
      @user = FactoryGirl.create(:user)
      @link = FactoryGirl.create(:link)
    end

    it "updates link when logged in" do
      patch :update, { id: @link, link: { short_url: "love" } }, user_id: @user.id
      @link.reload
      expect(@link.short_url).to eq("love")
    end

    it "does not update link when logged out" do
      patch :update, { id: @link, link: { short_url: "love" } }
      @link.reload
      expect(@link.short_url).not_to eq("love")
    end
  end

  describe "GET redirect_link" do
    before do
      @link = FactoryGirl.create(:link)
    end
    it "redirects short_url to url" do
      get :redirect_link, path: @link.short_url
      expect(response).to redirect_to @link.url
    end
  end
end
