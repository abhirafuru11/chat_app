class ChatsController < ApplicationController

  before_action :set_profile, only: [:index, :create]

  def index
    @chats = @profile.chats
  end

  def create
    @profile.chats.create(body: chat_params[:body], sender_type: 'user')

    ChatWorker.perform_async(chat_params[:body], @profile.id)

    respond_to do |format|
      format.turbo_stream #stream ai response
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:body)
  end

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
end

