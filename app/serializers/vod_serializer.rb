class VodSerializer < ActiveModel::Serializer
  attributes :id, :streamer_id, :twitch_id

  has_many :highlights
end
