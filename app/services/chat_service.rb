require 'net/http'

class ChatService
  class << self
    def call(chat_body, profile_id)
      profile = Profile.find_by(id: profile_id)
      payload = build_payload(chat_body, profile)
      payload = update_payload payload
      payload = build_message_history(payload, profile)

      send_message_to_ai(payload, profile)
    end

    private

    def build_payload(chat_body, profile)
      payload = {
        "your_name": 'Abhi',
        "user_input": chat_body,
        "name1": 'Abhi',
        "name2": profile.name,
        "greeting": 'Hello, how are you?',
        "context": "Candy AI, #{profile.gender}, #{profile.category}",
        "character": 'Example'
      }
    end

    def update_payload payload
      payload.merge!(ADDITIONAL_PAYLOAD)
    end

    def build_message_history(payload, profile)
      previous_message = ""
      #???include chat in controller???
      profile.chats.where(archived: false).order(:created_at).each_with_index do |message, index|
        if message.sender_type == "assistant"
        # If it's the first message from the assistant, we add the LLM format required
          if index == 0
            payload["history"]["internal"] << ["<|BEGIN-VISIBLE-message|>", message.body] if index == 0
            payload["history"]["visible"] << ["", message.body]
            else
              payload["history"]["internal"] << [previous_message, message.body]
              payload["history"]["visible"] << [previous_message, message.body]
            end

           previous_message = ""
        else
          previous_message = message.body
        end
      end
      payload
    end

    def send_message_to_ai(payload, profile)
      url = URI.parse(get_server_url)
      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Post.new(url.path, {'Content-Type' => 'application/json'})
      request.body = payload.to_json
      response = http.request(request)

      if response.is_a?(Net::HTTPSuccess)
        response_json = JSON.parse(response.body)
        profile.chats.create(
          body: response_json['results'][0]['history']['internal'].flatten.last,
          sender_type: 'assistant'
        )
      else
        puts "Error:: #{response.code} - #{response.message}"
      end

    end

    def get_server_url
      LoadBalancerService.call
    end
  end
end
