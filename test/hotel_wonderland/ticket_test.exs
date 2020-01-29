defmodule HotelWonderland.TicketTest do
  use HotelWonderland.DataCase

  alias HotelWonderland.Ticket

  describe "tickets" do
    alias HotelWonderland.Ticket.Tickets

    @valid_attrs %{message_subject: "some message_subject", message_text: "some message_text", name: "some name", phone: "some phone"}
    @update_attrs %{message_subject: "some updated message_subject", message_text: "some updated message_text", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{message_subject: nil, message_text: nil, name: nil, phone: nil}

    def tickets_fixture(attrs \\ %{}) do
      {:ok, tickets} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ticket.create_tickets()

      tickets
    end

    test "list_tickets/0 returns all tickets" do
      tickets = tickets_fixture()
      assert Ticket.list_tickets() == [tickets]
    end

    test "get_tickets!/1 returns the tickets with given id" do
      tickets = tickets_fixture()
      assert Ticket.get_tickets!(tickets.id) == tickets
    end

    test "create_tickets/1 with valid data creates a tickets" do
      assert {:ok, %Tickets{} = tickets} = Ticket.create_tickets(@valid_attrs)
      assert tickets.message_subject == "some message_subject"
      assert tickets.message_text == "some message_text"
      assert tickets.name == "some name"
      assert tickets.phone == "some phone"
    end

    test "create_tickets/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ticket.create_tickets(@invalid_attrs)
    end

    test "update_tickets/2 with valid data updates the tickets" do
      tickets = tickets_fixture()
      assert {:ok, %Tickets{} = tickets} = Ticket.update_tickets(tickets, @update_attrs)
      assert tickets.message_subject == "some updated message_subject"
      assert tickets.message_text == "some updated message_text"
      assert tickets.name == "some updated name"
      assert tickets.phone == "some updated phone"
    end

    test "update_tickets/2 with invalid data returns error changeset" do
      tickets = tickets_fixture()
      assert {:error, %Ecto.Changeset{}} = Ticket.update_tickets(tickets, @invalid_attrs)
      assert tickets == Ticket.get_tickets!(tickets.id)
    end

    test "delete_tickets/1 deletes the tickets" do
      tickets = tickets_fixture()
      assert {:ok, %Tickets{}} = Ticket.delete_tickets(tickets)
      assert_raise Ecto.NoResultsError, fn -> Ticket.get_tickets!(tickets.id) end
    end

    test "change_tickets/1 returns a tickets changeset" do
      tickets = tickets_fixture()
      assert %Ecto.Changeset{} = Ticket.change_tickets(tickets)
    end
  end
end
