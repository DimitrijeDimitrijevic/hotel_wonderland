defmodule HotelWonderlandWeb.Admin.AdminRoomController do
  use HotelWonderlandWeb, :controller

  alias HotelWonderland.Accounts
  alias HotelWonderland.Accounts.Room

  def index(conn, _params) do
    rooms_from_db = Accounts.list_available_rooms()
    rooms = Enum.reverse(rooms_from_db)
    render(conn, "index.html", rooms: rooms)
  end

  def index_all(conn, _params) do
    rooms_from_db = Accounts.list_rooms()
    rooms = Enum.reverse(rooms_from_db)
    IO.inspect rooms
    render(conn, "index-all.html", rooms: rooms)
  end

  def show_reservations(conn, _params) do
    rooms = Accounts.list_reservations(:preload)
    render(conn, "show-reservations.html", rooms)
  end

  def new(conn, _params) do
    changeset = Accounts.change_room(%Room{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"room" => room_params}) do
    case Accounts.create_room(room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room created successfully.")
        |> redirect(to: Routes.admin_room_path(conn, :show, room))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Accounts.get_room!(id)
    render(conn, "show.html", room: room)
  end

  def edit(conn, %{"id" => id}) do
    room = Accounts.get_room!(id)
    changeset = Accounts.change_room(room)
    render(conn, "edit.html", room: room, changeset: changeset)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Accounts.get_room!(id)

    case Accounts.update_room(room, room_params) do
      {:ok, room} ->
        conn
        |> put_flash(:info, "Room updated successfully.")
        |> redirect(to: Routes.admin_room_path(conn, :show, room))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", room: room, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Accounts.get_room!(id)
    {:ok, _room} = Accounts.delete_room(room)

    conn
    |> put_flash(:info, "Room deleted successfully.")
    |> redirect(to: Routes.admin_room_path(conn, :index))
  end
end
