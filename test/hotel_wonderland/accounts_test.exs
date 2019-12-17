defmodule HotelWonderland.AccountsTest do
  use HotelWonderland.DataCase

  alias HotelWonderland.Accounts

  describe "users" do
    alias HotelWonderland.Accounts.User

    @valid_attrs %{email: "some email", full_name: "some full_name", password_hash: "some password_hash", phone_number: "some phone_number"}
    @update_attrs %{email: "some updated email", full_name: "some updated full_name", password_hash: "some updated password_hash", phone_number: "some updated phone_number"}
    @invalid_attrs %{email: nil, full_name: nil, password_hash: nil, phone_number: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.full_name == "some full_name"
      assert user.password_hash == "some password_hash"
      assert user.phone_number == "some phone_number"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.full_name == "some updated full_name"
      assert user.password_hash == "some updated password_hash"
      assert user.phone_number == "some updated phone_number"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "rooms" do
    alias HotelWonderland.Accounts.Room

    @valid_attrs %{available: true, description: "some description", number_of_persons: 42, price: 42, type: "some type"}
    @update_attrs %{available: false, description: "some updated description", number_of_persons: 43, price: 43, type: "some updated type"}
    @invalid_attrs %{available: nil, description: nil, number_of_persons: nil, price: nil, type: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Accounts.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Accounts.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Accounts.create_room(@valid_attrs)
      assert room.available == true
      assert room.description == "some description"
      assert room.number_of_persons == 42
      assert room.price == 42
      assert room.type == "some type"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, %Room{} = room} = Accounts.update_room(room, @update_attrs)
      assert room.available == false
      assert room.description == "some updated description"
      assert room.number_of_persons == 43
      assert room.price == 43
      assert room.type == "some updated type"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_room(room, @invalid_attrs)
      assert room == Accounts.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Accounts.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Accounts.change_room(room)
    end
  end

  describe "reservations" do
    alias HotelWonderland.Accounts.Booking

    @valid_attrs %{guest_full_name: "some guest_full_name", phone: "some phone"}
    @update_attrs %{guest_full_name: "some updated guest_full_name", phone: "some updated phone"}
    @invalid_attrs %{guest_full_name: nil, phone: nil}

    def booking_fixture(attrs \\ %{}) do
      {:ok, booking} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_booking()

      booking
    end

    test "list_reservations/0 returns all reservations" do
      booking = booking_fixture()
      assert Accounts.list_reservations() == [booking]
    end

    test "get_booking!/1 returns the booking with given id" do
      booking = booking_fixture()
      assert Accounts.get_booking!(booking.id) == booking
    end

    test "create_booking/1 with valid data creates a booking" do
      assert {:ok, %Booking{} = booking} = Accounts.create_booking(@valid_attrs)
      assert booking.guest_full_name == "some guest_full_name"
      assert booking.phone == "some phone"
    end

    test "create_booking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_booking(@invalid_attrs)
    end

    test "update_booking/2 with valid data updates the booking" do
      booking = booking_fixture()
      assert {:ok, %Booking{} = booking} = Accounts.update_booking(booking, @update_attrs)
      assert booking.guest_full_name == "some updated guest_full_name"
      assert booking.phone == "some updated phone"
    end

    test "update_booking/2 with invalid data returns error changeset" do
      booking = booking_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_booking(booking, @invalid_attrs)
      assert booking == Accounts.get_booking!(booking.id)
    end

    test "delete_booking/1 deletes the booking" do
      booking = booking_fixture()
      assert {:ok, %Booking{}} = Accounts.delete_booking(booking)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_booking!(booking.id) end
    end

    test "change_booking/1 returns a booking changeset" do
      booking = booking_fixture()
      assert %Ecto.Changeset{} = Accounts.change_booking(booking)
    end
  end
end
