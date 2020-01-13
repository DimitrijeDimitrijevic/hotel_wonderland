defmodule HotelWonderlandWeb.Admin.AdminPostController do
    use HotelWonderlandWeb, :controller
  
    alias HotelWonderland.News
    alias HotelWonderland.News.Post
  
    def index(conn, _params) do
      posts = News.list_posts()
      render(conn, "index.html", posts: posts)
    end
  
    def new(conn, _params) do
      changeset = News.change_post(%Post{})
      render(conn, "new.html", changeset: changeset)
    end
  
    def create(conn, %{"post" => post_params}) do
      case News.create_post(post_params) do
        {:ok, post} ->
          conn
          |> put_flash(:info, "Post created successfully.")
          |> redirect(to: Routes.admin_post_path(conn, :show, post))
  
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  
    def show(conn, %{"id" => id}) do
      post = News.get_post!(id)
      render(conn, "show.html", post: post)
    end
  
    def edit(conn, %{"id" => id}) do
      post = News.get_post!(id)
      changeset = News.change_post(post)
      render(conn, "edit.html", post: post, changeset: changeset)
    end
  
    def update(conn, %{"id" => id, "post" => post_params}) do
      post = News.get_post!(id)
  
      case News.update_post(post, post_params) do
        {:ok, post} ->
          conn
          |> put_flash(:info, "Post updated successfully.")
          |> redirect(to: Routes.admin_post_path(conn, :show, post))
  
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", post: post, changeset: changeset)
      end
    end
  
    def delete(conn, %{"id" => id}) do
      post = News.get_post!(id)
      {:ok, _post} = News.delete_post(post)
  
      conn
      |> put_flash(:info, "Post deleted successfully.")
      |> redirect(to: Routes.admin_post_path(conn, :index))
    end
  end
  