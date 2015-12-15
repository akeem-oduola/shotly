class PagesController < ApplicationController
  def index
    @link = Link.new
  end
end
