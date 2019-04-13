class Vod < ApplicationRecord
  belongs_to :streamer
  has_many :highlights

  validates :twitch_id, uniqueness: true
end
