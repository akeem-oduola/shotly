json.array!(@links) do |link|
  json.extract! link, :id, :short_url, :url
  json.url link_url(link, format: :json)
end
