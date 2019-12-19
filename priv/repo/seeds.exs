alias HotelWonderland.Accounts

room_types = [
  %{type: "Single", number_of_persons: 1, price: 30, description: "Single Room"},
  %{type: "Comfort Single", number_of_persons: 1, price: 35, description: "Comfor Single Room"},
  %{type: "Double", number_of_persons: 2, price: 50, description: "Double Room"},
  %{type: "Comfort Double", number_of_persons: 2, price: 55, description: "Comfort Double Room"},
  %{type: "Triple", number_of_persons: 3, price: 60, description: "Triple Room"},
  %{type: "Comfort Triple", number_of_persons: 3, price: 65, description: "Comfort Triple Room"}
]

users = [
  %{
    full_name: "Dice",
    email: "dice@dice.com",
    password_hash: "somepassword",
    phone_number: "111111"
  },
  %{
    full_name: "Milan",
    email: "milan@milan.com",
    password_hash: "somepassword",
    phone_number: "222222"
  },
  %{
    full_name: "Misko",
    email: "misko@misko.com",
    password_hash: "somepassword",
    phone_number: "3333333"
  }
]

for x <- 1..3 do
  Enum.each(room_types, fn room -> Accounts.create_room(room) end)
end

Enum.each(users, fn user -> {:ok, _} = Accounts.create_user(user) end)
