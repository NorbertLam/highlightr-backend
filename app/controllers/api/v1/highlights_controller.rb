class Api::V1::HighlightsController < ApplicationController
  skip_before_action :authorized

  def create
    @highlight = Highlight.create(highlight_params)
    render json: HighlightSerializer.new(@highlight)
  end

  def show
    @highlight = Highlight.find_by(twitch_id: params[:twitch_id])
    render json: HighlightSerializer.new(@highlight)
  end

  private

  def highlight_params
    params.permit(:vod_id, :start, :end, :twitch_id)
  end
end
