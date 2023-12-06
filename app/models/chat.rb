class Chat < ApplicationRecord
	enum sender_type: { profile: 0, assistant: 1 }

  belongs_to :profile
end