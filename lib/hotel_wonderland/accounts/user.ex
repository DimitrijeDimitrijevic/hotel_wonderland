defmodule HotelWonderland.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :full_name, :string
    field :password_hash, :string
    field :phone_number, :string
    has_many :reservations, HotelWonderland.Accounts.Booking

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash, :full_name, :phone_number])
    |> validate_required([:email, :password_hash])
    |> validate_format(:email, ~r/\@/)
    |> validate_length(:full_name, min: 5)
    |> unique_constraint(:email)
    |> update_change(:password_hash, &Bcrypt.hash_pwd_salt/1)
  end
end
