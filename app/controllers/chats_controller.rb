class ChatsController < ApplicationController

  def create
    profile = Profile.find(params[:profile_id])
    profile.chats.create(body: chat_params[:body], sender_type: 'user')

    ChatWorker.perform_async(chat_params[:body], profile.id)

    respond_to do |format|
      #WIP
    end
  end

  private
  def chat_params
    params.require(:chat).permit(:body)
  end

end

