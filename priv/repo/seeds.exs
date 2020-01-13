alias HotelWonderland.Accounts
alias HotelWonderland.News


#inserting room_types for testing
room_types = [
  %{type: "Single", number_of_persons: 1, price: 30, description: "Single Room", benefits: "Here you can add benefits"},
  %{type: "Comfort Single", number_of_persons: 1, price: 35, description: "Comfor Single Room", benefits: "Here you can add benefits"},
  %{type: "Double", number_of_persons: 2, price: 50, description: "Double Room", benefits: "Here you can add benefits"},
  %{type: "Comfort Double", number_of_persons: 2, price: 55, description: "Comfort Double Room", benefits: "Here you can add benefits"},
  %{type: "Triple", number_of_persons: 3, price: 60, description: "Triple Room", benefits: "Here you can add benefits"},
  %{type: "Comfort Triple", number_of_persons: 3, price: 65, description: "Comfort Triple Room", benefits: "Here you can add benefits"}
]

#inserting users for testing
users = [
  %{
    full_name: "Dimitrije",
    email: "dice@dice.com",
    password_hash: "somepassword",
    phone_number: "+381123456789"
  },
  %{
    full_name: "Milan",
    email: "milan@milan.com",
    password_hash: "somepassword",
    phone_number: "+381123456789"
  },
  %{
    full_name: "Misko",
    email: "misko@misko.com",
    password_hash: "somepassword",
    phone_number: "+381123456789"
  }, 
  %{
    full_name: "admin",
    email: "admin@admin.com",
    password_hash: "somepassword",
    phone_number: "+381123456789"
  },
]

#inserting news for testing

news = [
  %{headline: "First Headlline", content: "First content"},
  %{headline: "Second Headline", content: "Second content"},
  %{headline: "Some headline", content: "some content"}
]

Enum.each(news, fn news -> {:ok, _} = News.create_post(news) end)

for x <- 1..3 do
  Enum.each(room_types, fn room -> Accounts.create_room(room) end)
end

Enum.each(users, fn user -> {:ok, _} = Accounts.create_user(user) end)
