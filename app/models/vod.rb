class Vod < ApplicationRecord
  belongs_to :streamer
  has_many :hilights
end
