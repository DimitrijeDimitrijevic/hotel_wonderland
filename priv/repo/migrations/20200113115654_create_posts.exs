defmodule HotelWonderland.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :headline, :string
      add :content, :text

      timestamps()
    end

  end
end
