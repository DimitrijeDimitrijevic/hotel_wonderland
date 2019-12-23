defmodule HotelWonderlandWeb.Admin.AdminBookingController do
  use HotelWonderlandWeb, :controller

  alias HotelWonderland.Accounts
  alias HotelWonderland.Accounts.Booking

  def index(conn, _params) do
    reservations = Accounts.list_reservations(:preload)
    render(conn, "index.html", reservations: reservations)
  end

  def new(conn, params) do
    IO.inspect(params)
    users = Accounts.list_users(:preload)
    changeset = Accounts.change_booking(%Booking{})
    render(conn, "new.html", changeset: changeset, users: users)
  end

  def create(conn, %{"booking" => booking_params}) do
    case Accounts.create_booking(booking_params) do
      {:ok, booking} ->
        room_id = booking_params["room_id"]
        room = Accounts.get_room!(room_id)
        Accounts.update_room(room, %{available: false})

        conn
        |> put_flash(:info, "Booking created successfully.")
        |> redirect(to: Routes.admin_booking_path(conn, :show, booking))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    booking = Accounts.get_booking!(id, :preload)
    render(conn, "show.html", booking: booking)
  end

  def edit(conn, %{"id" => id}) do
    booking = Accounts.get_booking!(id)
    changeset = Accounts.change_booking(booking)
    render(conn, "edit.html", booking: booking, changeset: changeset)
  end

  def update(conn, %{"id" => id, "booking" => booking_params}) do
    booking = Accounts.get_booking!(id)

    case Accounts.update_booking(booking, booking_params) do
      {:ok, booking} ->
        conn
        |> put_flash(:info, "Booking updated successfully.")
        |> redirect(to: Routes.booking_path(conn, :show, booking))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", booking: booking, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    booking = Accounts.get_booking!(id, :preload)
    room = Accounts.get_booking!(id, :preload).room
    Accounts.update_room(room, %{available: true})
    {:ok, _booking} = Accounts.delete_booking(booking)

    conn
    |> put_flash(:info, "Booking deleted successfully.")
    |> redirect(to: Routes.admin_booking_path(conn, :index))
  end
end
