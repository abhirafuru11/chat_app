# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Server.create([
  { name: 'server-1', url: 'http://34.36.42.74/api/v1/chat' },
  { name: 'server-2', url: 'http://34.36.42.74/api/v1/chat' }
])


number_of_profiles = 100000
profiles = []

number_of_profiles.times do |variable|
  profiles << {
    name: Faker::Name.name,
    category: Profile.categories.keys.sample,
    gender: Profile.genders.keys.sample
  }
end

Profile.insert_all(profiles)
