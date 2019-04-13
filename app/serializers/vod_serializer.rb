class VodSerializer < ActiveModel::Serializer
  attributes :id, :streamer_id, :twitch_id, :login

  has_many :highlights
end
