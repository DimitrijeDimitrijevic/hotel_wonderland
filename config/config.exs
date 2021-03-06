# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hotel_wonderland,
  ecto_repos: [HotelWonderland.Repo]

# Configures the endpoint
config :hotel_wonderland, HotelWonderlandWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Cdhq6OzCxc6qp+TexUhxcLTDEI4v7Jo+UwG7sXZTKHHIzLXkr1PlO72qUusRS9QI",
  render_errors: [view: HotelWonderlandWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HotelWonderland.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :hotel_wonderland, admin_config: [
    username: "admin",
    password: "admin",
    realm: "Admin Area"
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
