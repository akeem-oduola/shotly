class PagesController < ApplicationController
  def index
    @link = Link.new
    @popular = Link.popular.limit(5) unless (Link.popular).nil?
    @recent = Link.recent.limit(5)
  end
end
