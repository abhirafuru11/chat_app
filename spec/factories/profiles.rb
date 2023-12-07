FactoryBot.define do
  factory :profile do
    name { Faker::Name.name }
    category { Profile.categories.keys.sample }
    gender { Profile.genders.keys.sample }
  end
end
