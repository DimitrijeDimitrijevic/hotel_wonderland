defmodule HotelWonderland.Accounts.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :available, :boolean, default: true
    field :description, :string
    field :number_of_persons, :integer
    field :price, :integer
    field :type, :string
    has_one :reservations, HotelWonderland.Accounts.Booking
    

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:type, :available, :number_of_persons, :description, :price])
    |> validate_required([:type, :available, :number_of_persons, :description, :price])
  end
end
