Rails.application.routes.draw do
  get("/", { :controller => "places", :action => "index" })

  resources "entries"
  resources "places"
  resources "users"

  # Authentication Routes
  get "/signup", to: "users#new"
  post "/users", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"


  resources "sessions", only: [:new, :create, :destroy]
end
