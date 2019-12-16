defmodule HotelWonderlandWeb.PageController do
  use HotelWonderlandWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
