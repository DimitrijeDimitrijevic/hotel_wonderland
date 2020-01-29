defmodule HotelWonderlandWeb.TicketsController do
  use HotelWonderlandWeb, :controller

  alias HotelWonderland.Ticket
  alias HotelWonderland.Ticket.Tickets

  def index(conn, _params) do
    tickets = Ticket.list_tickets()
    render(conn, "index.html", tickets: tickets)
  end

  def new(conn, _params) do
    changeset = Ticket.change_tickets(%Tickets{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tickets" => tickets_params}) do
    case Ticket.create_tickets(tickets_params) do
      {:ok, tickets} ->
        conn
        |> put_flash(:info, "Tickets created successfully.")
        |> redirect(to: Routes.tickets_path(conn, :show, tickets))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tickets = Ticket.get_tickets!(id)
    render(conn, "show.html", tickets: tickets)
  end

  def edit(conn, %{"id" => id}) do
    tickets = Ticket.get_tickets!(id)
    changeset = Ticket.change_tickets(tickets)
    render(conn, "edit.html", tickets: tickets, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tickets" => tickets_params}) do
    tickets = Ticket.get_tickets!(id)

    case Ticket.update_tickets(tickets, tickets_params) do
      {:ok, tickets} ->
        conn
        |> put_flash(:info, "Tickets updated successfully.")
        |> redirect(to: Routes.tickets_path(conn, :show, tickets))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tickets: tickets, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tickets = Ticket.get_tickets!(id)
    {:ok, _tickets} = Ticket.delete_tickets(tickets)

    conn
    |> put_flash(:info, "Tickets deleted successfully.")
    |> redirect(to: Routes.tickets_path(conn, :index))
  end
end
