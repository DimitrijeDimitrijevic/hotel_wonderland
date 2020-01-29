defmodule HotelWonderland.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :name, :string
      add :phone, :string
      add :message_subject, :string
      add :message_text, :string

      timestamps()
    end

  end
end
