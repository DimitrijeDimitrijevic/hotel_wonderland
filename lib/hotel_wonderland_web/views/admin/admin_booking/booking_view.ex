defmodule HotelWonderlandWeb.Admin.AdminBookingView do
  use HotelWonderlandWeb, :view

  alias HotelWonderland.Accounts

  def get_admin_id(), do: Accounts.get_admin_id()
end
