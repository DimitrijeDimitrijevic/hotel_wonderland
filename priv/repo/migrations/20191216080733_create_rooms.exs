defmodule HotelWonderland.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :type, :string, null: false
      add :available, :boolean, default: true, null: false
      add :number_of_persons, :integer
      add :description, :string
      add :price, :integer

      timestamps()
    end

  end
end
