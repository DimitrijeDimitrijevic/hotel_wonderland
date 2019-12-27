defmodule HotelWonderland.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :type, :string, null: false
      add :available, :boolean, default: true, null: false
      add :number_of_persons, :integer
      add :description, :string
      add :price, :integer
      add :benefits, :string

      timestamps()
    end

  end
end
