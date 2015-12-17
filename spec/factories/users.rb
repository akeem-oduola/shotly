FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "1234567"
    name "user mock"
    image_url "http://graph.facebook.com/1234567/picture?type=square"
  end
end
