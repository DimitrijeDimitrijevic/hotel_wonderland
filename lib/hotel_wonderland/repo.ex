defmodule HotelWonderland.Repo do
  use Ecto.Repo,
    otp_app: :hotel_wonderland,
    adapter: Ecto.Adapters.Postgres
end
