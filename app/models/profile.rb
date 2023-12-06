class Profile < ApplicationRecord
  enum category: { anime: 0, realistic: 1 }
  enum gender: { male: 0, female: 1 }

  has_many :chats

  def self.ransackable_attributes(auth_object = nil)
    ["category", "gender"]
  end
end
