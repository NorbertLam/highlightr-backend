Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post "/login", to: "auth#create"
      post "/signup", to: "users#create"
      get "/profile/:id", to: "users#show"
      get "/streamers", to: "streamers#index"
      get "/streamers/:login", to: "streamers#show"
    end
  end
end
