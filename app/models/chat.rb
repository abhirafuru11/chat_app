class Chat < ApplicationRecord
	include ActionView::RecordIdentifier

	enum sender_type: { user: 0, assistant: 1 }

	belongs_to :profile

	after_create_commit -> { broadcast_created_chat }

	def broadcast_created_chat
		broadcast_append_later_to(
			"#{dom_id(profile)}_chats",#channel_name
			partial: "chats/chat",
			locals: { chat: self, scroll_to: true },
			target: "#{dom_id(profile)}_chats"
		)
	end
end
