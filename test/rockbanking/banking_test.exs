defmodule RockBanking.BankingTest do
  use RockBanking.DataCase

  alias RockBanking.Banking

  describe "users" do
    alias RockBanking.Banking.User

    @valid_attrs %{balance: 120.5, email: "some email", id: "7488a646-e31f-11e4-aace-600308960662", name: "some name", password_hash: "some password_hash"}
    @update_attrs %{balance: 456.7, email: "some updated email", id: "7488a646-e31f-11e4-aace-600308960668", name: "some updated name", password_hash: "some updated password_hash"}
    @invalid_attrs %{balance: nil, email: nil, id: nil, name: nil, password_hash: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Banking.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Banking.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Banking.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Banking.create_user(@valid_attrs)
      assert user.balance == 120.5
      assert user.email == "some email"
      assert user.id == "7488a646-e31f-11e4-aace-600308960662"
      assert user.name == "some name"
      assert user.password_hash == "some password_hash"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Banking.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Banking.update_user(user, @update_attrs)
      assert user.balance == 456.7
      assert user.email == "some updated email"
      assert user.id == "7488a646-e31f-11e4-aace-600308960668"
      assert user.name == "some updated name"
      assert user.password_hash == "some updated password_hash"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Banking.update_user(user, @invalid_attrs)
      assert user == Banking.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Banking.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Banking.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Banking.change_user(user)
    end
  end
end
