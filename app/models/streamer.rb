class Streamer < ApplicationRecord
  has_many :vods
  has_many :highlights, through: :vods
end
