class ProfilesController < ApplicationController

  def index
    @search_result = Profile.ransack(params[:q])
    @profiles = @search_result.result.page(params[:page]).per(10)
  end
end
