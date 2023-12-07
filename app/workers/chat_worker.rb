class ChatWorker
  include Sidekiq::Worker

  def perform(chat_body, profile_id)
    response = ChatService.call(chat_body, profile_id)
  end
end



