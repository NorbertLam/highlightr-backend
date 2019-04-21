# Highlightr Backend

Ruby on Rails backend for Highlightr. User information is persisted through a sign up process, allowing users to log in and customize their experience. Uses JWT as an eimplmentation of auth. Handles streamers, VoDs, and VoD highlights. A Python3 script parses twitch chat logs and analyzes them for "highlights".

### Installation and Usage
```
bundle i
rails db:create db:migrate db:seed
rails s
```

### Environment Variables
Create a .env file containing the following.
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
             api_v1_login POST /api/v1/login                                                                  api/v1/auth#create
      api_v1_current_user GET  /api/v1/current_user                                                           api/v1/auth#show
            api_v1_signup POST /api/v1/signup                                                                 api/v1/users#create
                   api_v1 GET  /api/v1/profile/:id                                                            api/v1/users#show
         api_v1_streamers GET  /api/v1/streamers                                                              api/v1/streamers#index
                          GET  /api/v1/streamers/:login                                                       api/v1/streamers#show
               api_v1_vod POST /api/v1/vod                                                                    api/v1/vods#create
                          GET  /api/v1/vod/:twitch_id                                                         api/v1/vods#show
         api_v1_highlight POST /api/v1/highlight                                                              api/v1/highlights#create
                          GET  /api/v1/highlight/:id                                                          api/v1/highlights#show
```

### Directory Structure
```
app/ - Contains controllers, models, and serializers
  controllers/
    api/
      v1/ Controllers for auth, highlights, streamers, users, vods
  models/ - Models for highlight, streamer, user, vod
  serializers/ - Serializers for highlight, streamers, user, vod

db/ - Database migration files, schema, and seed
  migrate/ - Migrations files for creating users, streamers, highlights, and vods

.env - Environment Variables
```

# findHighlights.py
The Twitch Chat for a VoD is downloaded using https://github.com/PetterKraabol/Twitch-Chat-Downloader.
findHighlights.py scans the directory for appropriate .txt files, parses each file and then sends a post request to backend server, persisting each timestamp as a highlight.

### Usage
```
python3 findHighlights.py
```
