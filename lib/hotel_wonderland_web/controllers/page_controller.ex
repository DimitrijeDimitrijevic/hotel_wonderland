defmodule HotelWonderlandWeb.PageController do
  use HotelWonderlandWeb, :controller

  alias HotelWonderland.News

  def index(conn, _params) do
    news = News.list_posts() |> Enum.reverse()
    render(conn, "index.html", news: news)
  end

  def contact(conn, _params) do
    render(conn, "contact-page.html")
  end
end
