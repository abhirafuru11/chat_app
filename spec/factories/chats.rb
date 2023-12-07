FactoryBot.define do
  factory :chat do
    archived { [true, false].sample }
    body { Faker::Lorem.sentence }
    association :profile
    sender_type { %w[user assistant].sample }
  end
end
