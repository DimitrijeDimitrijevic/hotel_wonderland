defmodule HotelWonderlandWeb.TicketsControllerTest do
  use HotelWonderlandWeb.ConnCase

  alias HotelWonderland.Ticket

  @create_attrs %{message_subject: "some message_subject", message_text: "some message_text", name: "some name", phone: "some phone"}
  @update_attrs %{message_subject: "some updated message_subject", message_text: "some updated message_text", name: "some updated name", phone: "some updated phone"}
  @invalid_attrs %{message_subject: nil, message_text: nil, name: nil, phone: nil}

  def fixture(:tickets) do
    {:ok, tickets} = Ticket.create_tickets(@create_attrs)
    tickets
  end

  describe "index" do
    test "lists all tickets", %{conn: conn} do
      conn = get(conn, Routes.tickets_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tickets"
    end
  end

  describe "new tickets" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tickets_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tickets"
    end
  end

  describe "create tickets" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tickets_path(conn, :create), tickets: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tickets_path(conn, :show, id)

      conn = get(conn, Routes.tickets_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tickets"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tickets_path(conn, :create), tickets: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tickets"
    end
  end

  describe "edit tickets" do
    setup [:create_tickets]

    test "renders form for editing chosen tickets", %{conn: conn, tickets: tickets} do
      conn = get(conn, Routes.tickets_path(conn, :edit, tickets))
      assert html_response(conn, 200) =~ "Edit Tickets"
    end
  end

  describe "update tickets" do
    setup [:create_tickets]

    test "redirects when data is valid", %{conn: conn, tickets: tickets} do
      conn = put(conn, Routes.tickets_path(conn, :update, tickets), tickets: @update_attrs)
      assert redirected_to(conn) == Routes.tickets_path(conn, :show, tickets)

      conn = get(conn, Routes.tickets_path(conn, :show, tickets))
      assert html_response(conn, 200) =~ "some updated message_subject"
    end

    test "renders errors when data is invalid", %{conn: conn, tickets: tickets} do
      conn = put(conn, Routes.tickets_path(conn, :update, tickets), tickets: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tickets"
    end
  end

  describe "delete tickets" do
    setup [:create_tickets]

    test "deletes chosen tickets", %{conn: conn, tickets: tickets} do
      conn = delete(conn, Routes.tickets_path(conn, :delete, tickets))
      assert redirected_to(conn) == Routes.tickets_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.tickets_path(conn, :show, tickets))
      end
    end
  end

  defp create_tickets(_) do
    tickets = fixture(:tickets)
    {:ok, tickets: tickets}
  end
end
