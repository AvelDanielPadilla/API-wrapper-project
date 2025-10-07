Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      namespace :lotr do
        get "/character", to: "lotr#get_character"
        get "/quote", to: "lotr#get_quote"
        get "/book", to: "lotr#get_book"
        get "/chapter", to: "lotr#get_chapter"
        get "/movie", to: "lotr#get_movie"
        get "/bad_route", to: "lotr#get_error"
      end
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
  # match "*path", to: "application#route_not_found", via: :all
end
