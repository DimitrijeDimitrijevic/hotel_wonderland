defmodule HotelWonderland.Repo.Migrations.CreateReservations do
  use Ecto.Migration

  def change do
    create table(:reservations) do
      add :guest_full_name, :string
      add :phone, :string
      add :check_in, :date
      add :check_out, :date
      add :special_requests, :string
      add :room_id, references(:rooms, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:reservations, [:room_id])
    create index(:reservations, [:user_id])
    create index(:reservations, [:room_id, :user_id])
  end
end
