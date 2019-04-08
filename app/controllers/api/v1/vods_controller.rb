class Api::V1::VodsController < ApplicationController
  skip_before_action :authorized

  def create
    @vod = Vod.create(vod_params)
    render json: VodSerializer.new(@vod)
  end

  def show
    @vod = Vod.find_by(vod_id: params[:vod_id])
    render json: VodSerializer.new(@vod)
  end

  private

  def vod_params
    params.permit(:streamer_id, :vod_id)
  end
end
