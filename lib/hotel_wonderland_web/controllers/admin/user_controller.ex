defmodule HotelWonderlandWeb.Admin.AdminUserController do
    use HotelWonderlandWeb, :controller

    alias HotelWonderland.Accounts
    alias HotelWonderland.Accounts.User
  
    def index(conn, _params) do
      users = Accounts.list_users()
      render(conn, "index.html", users: users)
    end
  
    def new(conn, _params) do
      changeset = Accounts.change_user(%User{})
      render(conn, "new.html", changeset: changeset)
    end
  
    def create(conn, %{"user" => user_params}) do
      case Accounts.create_user(user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "Admin created user successfully.")
          |> redirect(to: Routes.admin_user_path(conn, :show, user))
  
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
      end
    end
  
    def show(conn, %{"id" => id}) do
      user = Accounts.get_user!(id, :preload)
      IO.inspect(user)
      render(conn, "show.html", user: user)
    end
  
    def edit(conn, %{"id" => id}) do
      user = Accounts.get_user(id)
      changeset = Accounts.change_user(user)
      render(conn, "edit.html", user: user, changeset: changeset)
    end
  
    def update(conn, %{"id" => id, "user" => user_params}) do
      IO.inspect(user_params)
      user = Accounts.get_user(id)
  
      case Accounts.update_user(user, user_params) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "Admin updated user successfully.")
          |> redirect(to: Routes.admin_user_path(conn, :show, user))
  
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", user: user, changeset: changeset)
      end
    end
  
    def delete(conn, _paramas) do
      user = conn.assigns.current_user
      {:ok, _user} = Accounts.delete_user(user)
  
      conn
      |> put_flash(:info, "User deleted successfully.")
      |> redirect(to: Routes.user_path(conn, :index))
    end
end