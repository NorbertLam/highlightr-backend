class Api::V1::StreamersController < ApplicationController

  def index
    @streamers = Streamer.all
    render json: @streamers
  end

  def show
    @streamer = Streamer.find_by(display_name: params[:display_name])
    render json: @streamer
  end

  def create
    @streamer = Streamer.create(streamer_params)
    render json: @streamer
  end

  private

  def streamer_params
    params.permit(:twitch_id, :login, :display_name, :broadcaster_type, :description, :profile_image_url, :offline_image_url)
  end

end
