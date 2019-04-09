class VodSerializer < ActiveModel::Serializer
  attributes :streamer_id, :twitch_id

  has_many :highlights
end
