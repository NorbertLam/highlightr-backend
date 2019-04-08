Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post "/login", to: "auth#create"
      get '/current_user', to: 'auth#show'
      
      post "/signup", to: "users#create"
      get "/profile/:id", to: "users#show"
      
      get "/streamers", to: "streamers#index"
      get "/streamers/:login", to: "streamers#show"

      post "/vod", to: "vods#create"
      get "/vod", to: "vods#show"
    end
  end
end
