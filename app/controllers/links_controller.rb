class LinksController < ApplicationController
  include LinksHelper
  include ClicksHelper

  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:create, :redirect_link]

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])
    @num_of_days = (params[:num_of_days] || 15).to_i
    @count_days_bar = Click.count_days_bar(params[:id], @num_of_days)
    chart = Click.count_country_chart(params[:id], params[:map] || "world")
    @count_country_map = chart[:map]
    @count_country_bar = chart[:bar]
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    @link.user_id = (current_user) ? session[:user_id] : 0

    respond_to do |format|
      if @link.save
        if current_user
          format.html do
            redirect_to dashboard_path, notice: "Link was successfully created."
          end
        else
          format.html do
            redirect_to root_path, notice: "Link was successfully created."
          end
          format.json { render :show, status: :created, location: @link }
        end
      else
        flash[:error] = "Url field is empty, please enter information."
        format.html { redirect_to :back }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
      respond_to do |format|
        if @link.update(link_params)
          format.html do
            redirect_to dashboard_path, notice: "Link was successfully updated."
          end
          format.json { render :show, status: :ok, location: @link }
        else
          format.html { render :edit }
          format.json { render json: @link.errors, status: :unprocessable_entity }
        end
      end
    end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
  end

  def redirect_link
    @link = Link.find_by(short_url: params[:path])
    if @link.active && !@link.deleted
      click = @link.clicks.new(ip: get_remote_ip)
      click.country = get_remote_country
      click.save
      @link.save
      redirect_to @link.url
    elsif @link.deleted
      redirect_to root_path, alert: "Link has been deleted by owner."
    else
      redirect_to root_path, alert: "Link is curently inactive."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:id,:short_url, :url, :active, :deleted)
    end
end
