class Vod < ApplicationRecord
  belongs_to :streamer
  has_many :hilights

  validates :vod_id, uniqueness: true
end
