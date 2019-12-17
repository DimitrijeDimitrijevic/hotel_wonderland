defmodule HotelWonderlandWeb.Router do
  use HotelWonderlandWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug HotelWonderlandWeb.Helpers.AuthPlug
  end

  scope "/", HotelWonderlandWeb do
    pipe_through [:browser, :auth]
    resources "/users", UserController, only: [:show, :edit, :update], singleton: true
  end

  scope "/", HotelWonderlandWeb do
    pipe_through [:browser]

    get "/", PageController, :index
    resources "/rooms", RoomController
    resources "/reservations", BookingController

    # Sign in
    get "/sign-in", SessionController, :sign_in
    post "/sign-in", SessionController, :create_session

    # Sign up
    get "/sign-up", SessionController, :sign_up
    post "/sign-up", SessionController, :create_user

    # Sign out
    post "/sign-out", SessionController, :sign_out
  end

  # Other scopes may use custom stacks.
  # scope "/api", HotelWonderlandWeb do
  #   pipe_through :api
  # end
end
