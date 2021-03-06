defmodule HotelWonderlandWeb.BookingControllerTest do
  use HotelWonderlandWeb.ConnCase

  alias HotelWonderland.Accounts

  @create_attrs %{guest_full_name: "some guest_full_name", phone: "some phone"}
  @update_attrs %{guest_full_name: "some updated guest_full_name", phone: "some updated phone"}
  @invalid_attrs %{guest_full_name: nil, phone: nil}

  def fixture(:booking) do
    {:ok, booking} = Accounts.create_booking(@create_attrs)
    booking
  end

  describe "index" do
    test "lists all reservations", %{conn: conn} do
      conn = get(conn, Routes.booking_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Reservations"
    end
  end

  describe "new booking" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.booking_path(conn, :new))
      assert html_response(conn, 200) =~ "New Booking"
    end
  end

  describe "create booking" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.booking_path(conn, :create), booking: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.booking_path(conn, :show, id)

      conn = get(conn, Routes.booking_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Booking"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.booking_path(conn, :create), booking: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Booking"
    end
  end

  describe "edit booking" do
    setup [:create_booking]

    test "renders form for editing chosen booking", %{conn: conn, booking: booking} do
      conn = get(conn, Routes.booking_path(conn, :edit, booking))
      assert html_response(conn, 200) =~ "Edit Booking"
    end
  end

  describe "update booking" do
    setup [:create_booking]

    test "redirects when data is valid", %{conn: conn, booking: booking} do
      conn = put(conn, Routes.booking_path(conn, :update, booking), booking: @update_attrs)
      assert redirected_to(conn) == Routes.booking_path(conn, :show, booking)

      conn = get(conn, Routes.booking_path(conn, :show, booking))
      assert html_response(conn, 200) =~ "some updated guest_full_name"
    end

    test "renders errors when data is invalid", %{conn: conn, booking: booking} do
      conn = put(conn, Routes.booking_path(conn, :update, booking), booking: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Booking"
    end
  end

  describe "delete booking" do
    setup [:create_booking]

    test "deletes chosen booking", %{conn: conn, booking: booking} do
      conn = delete(conn, Routes.booking_path(conn, :delete, booking))
      assert redirected_to(conn) == Routes.booking_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.booking_path(conn, :show, booking))
      end
    end
  end

  defp create_booking(_) do
    booking = fixture(:booking)
    {:ok, booking: booking}
  end
end
