class Link < ActiveRecord::Base
  before_create :set_short_url
  before_save :url_check
  has_many :clicks
  validates :url, presence: true

  scope :recent, lambda {
    order("links.created_at DESC")
  }

  scope :popular, lambda {
    order("links.clicks_count desc")
  }

  private

  def url_check
    self.url = (url[0..3] == "http") ? url : "http://" + url
  end

  def set_short_url
    return short_url if short_url.present?
    
    try_short_url = SecureRandom.urlsafe_base64(4)
    while Link.where(:short_url => try_short_url).any?
      try_short_url = SecureRandom.urlsafe_base64(4)
    end
    self.short_url = try_short_url
  end
end
