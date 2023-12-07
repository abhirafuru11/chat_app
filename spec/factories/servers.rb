# spec/factories/servers.rb

FactoryBot.define do
  factory :server do
    sequence(:name) { |n| "server#{n}" }
    url { 'http://34.36.42.74/api/v1/chat' }
  end
end
