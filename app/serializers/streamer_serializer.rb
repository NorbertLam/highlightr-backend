class StreamerSerializer < ActiveModel::Serializer
  attributes :twitch_id, :login, :display_name, :broadcaster_type, :description, :profile_image_url, :offline_image_url
end
