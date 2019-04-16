require 'rest-client'
require 'dotenv/load'
require 'json'

def getStreamers(streamerArr)  
  streamerArr.each do |streamer|
    resp = JSON.parse(RestClient.get("https://api.twitch.tv/helix/users?login=#{streamer}", {"Client-ID": "#{ENV['KEY']}"}))
    createStreamers(resp["data"][0])
  end
end

def createStreamers(streamerData)
  Streamer.create( 
    twitch_id: streamerData["id"],
    login: streamerData["login"],
    display_name: streamerData["display_name"],
    broadcaster_type: streamerData["broadcaster_type"],
    description: streamerData["description"],
    profile_image_url: streamerData["profile_image_url"],
    offline_image_url: streamerData["offline_image_url"] 
    )
end
  
streamersArr = ['shroud', 'imaqtpie', 'sodapoppin', 'pokimane', 'riotgames', 'jakenbakelive']

getStreamers(streamersArr)
