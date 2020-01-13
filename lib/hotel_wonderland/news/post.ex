defmodule HotelWonderland.News.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :headline, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:headline, :content])
    |> validate_required([:headline, :content])
  end
end
