require "faker"

FactoryGirl.define do
  factory :link do
    url { Faker::Internet.url }
  end

  factory :invalid_link, parent: :link do
    url nil
  end
end
