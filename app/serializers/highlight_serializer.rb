class HighlightSerializer < ActiveModel::Serializer
  attributes :vod_id, :start, :end, :twitch_id
end
