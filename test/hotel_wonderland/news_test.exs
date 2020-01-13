defmodule HotelWonderland.NewsTest do
  use HotelWonderland.DataCase

  alias HotelWonderland.News

  describe "posts" do
    alias HotelWonderland.News.Post

    @valid_attrs %{content: "some content", headline: "some headline"}
    @update_attrs %{content: "some updated content", headline: "some updated headline"}
    @invalid_attrs %{content: nil, headline: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> News.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert News.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert News.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = News.create_post(@valid_attrs)
      assert post.content == "some content"
      assert post.headline == "some headline"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = News.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = News.update_post(post, @update_attrs)
      assert post.content == "some updated content"
      assert post.headline == "some updated headline"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = News.update_post(post, @invalid_attrs)
      assert post == News.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = News.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> News.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = News.change_post(post)
    end
  end
end
