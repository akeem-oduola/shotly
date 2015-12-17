module ClicksHelper
  def get_remote_ip
    request.remote_ip
  end

  def get_remote_country
    request.location.country
  end
end
