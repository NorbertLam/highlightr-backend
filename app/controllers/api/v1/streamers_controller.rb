require 'rest-client'
require 'dotenv/load'
require 'json'

class Api::V1::StreamersController < ApplicationController
  skip_before_action :authorized

  def index
    @streamers = Streamer.all
    render json: @streamers
  end

  def show
    @streamer = Streamer.find_or_create_by(login: params[:login]) do |streamer|
      resp = JSON.parse(RestClient.get("https://api.twitch.tv/helix/users?login=#{params[:login]}", 
        {"Client-ID": "#{ENV['KEY']}"}))
      data = resp["data"][0]
      
      streamer.twitch_id = data["id"]
      streamer.display_name = data["display_name"]
      streamer.broadcaster_type = data["broadcaster_type"]
      streamer.description = data["description"]
      streamer.profile_image_url = data["profile_image_url"]
      streamer.offline_image_url = data["offline_image_url"]
    end
    
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
