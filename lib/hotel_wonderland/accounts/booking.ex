defmodule HotelWonderland.Accounts.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reservations" do
    field :guest_full_name, :string
    field :phone, :string
    field :check_in, :date
    field :check_out, :date
    field :special_requests, :string
    belongs_to :room, HotelWonderland.Accounts.Room
    belongs_to :user, HotelWonderland.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [:guest_full_name, :phone])
    |> validate_required([:guest_full_name, :phone])
  end
end
