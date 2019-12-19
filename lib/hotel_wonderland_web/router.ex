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

  pipeline :admin do
    plug :put_layout, {HotelWonderlandWeb.LayoutView, "admin.html"}
    plug BasicAuth, use_config: {:hotel_wonderland, :admin_config}
  end

  scope "/", HotelWonderlandWeb do
    pipe_through [:browser]

    get "/", PageController, :index

    get "/rooms", RoomController, :index

    # Sign in
    get "/sign-in", SessionController, :sign_in
    post "/sign-in", SessionController, :create_session

    # Sign up
    get "/sign-up", SessionController, :sign_up
    post "/sign-up", SessionController, :create_user

    # Sign out
    post "/sign-out", SessionController, :sign_out
  end

  scope "/", HotelWonderlandWeb do
    pipe_through [:browser, :auth]

    get "/rooms", RoomController, :index

    resources "/profile", UserController, only: [:show, :edit, :update], singleton: true do
      resources "/reservations", BookingController
    end
  end

  scope "/admin", HotelWonderlandWeb do
    pipe_through [:browser, :admin]

    get "/", AdminController, :index

    resources "/users", UserController
    resources "/rooms", RoomController
    resources "/reservations", BookingController
    get "/all-reservations", BookingController, :index_all_reservations
    get "/all-rooms", RoomController, :index_all_rooms


  end

  # Other scopes may use custom stacks.
  # scope "/api", HotelWonderlandWeb do
  #   pipe_through :api
  # end
end
