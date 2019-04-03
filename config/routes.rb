Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post "/signup", to: "users#create"
      get "/profile", to: "users#show"
    end
  end
end
