# Highlightr Backend

Ruby on Rails backend for Highlightr. Persists user information through sign up and log in. Handles streamers, VoDs, and highlights.
Includes a python script used to parse twitch chat logs and analyzed for "highlights".

### Installation and Usage
```
bundle i
rails db:create db:migrate db:seed
rails s
```

### Environment Variables
Create .env file containing the following.
```
export KEY=YOUR TWITCH CLIENT ID
export SECRET=YOUR SECRET FOR JWT
```

### Models and Relationships
```
Streamer has many Vods, has many highlights through Vods
Vod belongs to Streamer, has many highlights
Highlight belongs to Vod

User
 - email
 - password
 - username
 - first_name
 - profile_picture

Streamer
  - twitch_id
  - login
  - display_name
  - broadcaster_type
  - description
  - profile_image_url
  - offline_image_url

Vod
  - streamer_id
  - twitch_id
  - login

Highlight
 - vod_id
 - twitch_id
 - start
 - end
```

### Routes
```
             api_v1_login POST /api/v1/login(.:format)                                                                  api/v1/auth#create
      api_v1_current_user GET  /api/v1/current_user(.:format)                                                           api/v1/auth#show
            api_v1_signup POST /api/v1/signup(.:format)                                                                 api/v1/users#create
                   api_v1 GET  /api/v1/profile/:id(.:format)                                                            api/v1/users#show
         api_v1_streamers GET  /api/v1/streamers(.:format)                                                              api/v1/streamers#index
                          GET  /api/v1/streamers/:login(.:format)                                                       api/v1/streamers#show
               api_v1_vod POST /api/v1/vod(.:format)                                                                    api/v1/vods#create
                          GET  /api/v1/vod/:twitch_id(.:format)                                                         api/v1/vods#show
         api_v1_highlight POST /api/v1/highlight(.:format)                                                              api/v1/highlights#create
                          GET  /api/v1/highlight/:id(.:format)                                                          api/v1/highlights#show
```

# findHighlights.py
Downloaded Twitch Chat through https://github.com/PetterKraabol/Twitch-Chat-Downloader.
Script scans directory for .txt files named with numbers as Twitch Chat Downloader saves the logs as VodId.txt. 
Parses each file and then sends a post request to backend server, persisting each timestamp as a highlight. 

### Usage
```
python3 findHighlights.py
```
