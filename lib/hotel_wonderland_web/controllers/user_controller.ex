defmodule HotelWonderlandWeb.UserController do
  use HotelWonderlandWeb, :controller

  alias HotelWonderland.Accounts
  alias HotelWonderland.Accounts.User

 # def index(conn, _params) do
 #  users = Accounts.list_users()
  #  render(conn, "index.html", users: users)
 # end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    user = conn.assigns.current_user
    
    user = Accounts.get_user!(user.id, :preload)
    IO.inspect(user)
   # bookings = Accounts.get_user_reservations(user.id)  #add bookings in render
    render(conn, "show.html", user: user)
  end

  def edit(conn, _params) do
    user = conn.assigns.current_user
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, _params) do
    user = conn.assigns.current_user

    case Accounts.update_user(user, _params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

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
