class ChatWorker
  include Sidekiq::Worker

  def perform(message_body, profile_id)
    response = ChatService.call(message_body, profile_id)
  end
end



