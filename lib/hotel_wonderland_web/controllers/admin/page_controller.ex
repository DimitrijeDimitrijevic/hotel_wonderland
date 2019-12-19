defmodule HotelWonderlandWeb.Admin.AdminPageController do
    use HotelWonderlandWeb, :controller
    
    def index(conn, _paramas) do
        render(conn, "index.html")
      end
end