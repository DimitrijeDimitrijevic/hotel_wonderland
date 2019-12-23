defmodule HotelWonderlandWeb.Admin.AdminBookingView do
  use HotelWonderlandWeb, :view

  alias HotelWonderland.Accounts

  def get_admin_id do
    admin = Accounts.get_admin_id()
    admin_id = List.first(admin)
  end
end
