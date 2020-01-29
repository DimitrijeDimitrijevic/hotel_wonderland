defmodule HotelWonderland.Ticket.Tickets do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :message_subject, :string
    field :message_text, :string
    field :name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(tickets, attrs) do
    tickets
    |> cast(attrs, [:name, :phone, :message_subject, :message_text])
    |> validate_required([:name, :phone, :message_subject, :message_text])
  end
end
