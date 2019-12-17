defmodule HotelWonderland.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :full_name, :string
      add :phone_number, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
