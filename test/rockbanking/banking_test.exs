defmodule RockBanking.BankingTest do
  use RockBanking.DataCase

  alias RockBanking.Banking

  describe "create_user/1" do
    test "returns success and a created user when attrs passed are valid" do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "1234"
      }

      assert {:ok, user} = Banking.create_user(attrs)
      assert user.email == "some@email.net"
      assert user.name == "My Name"
      assert user.password_hash != "1234"
      assert user.password_hash != ""
      assert user.balance == 0
    end

    test "returns an error and an Ecto.Changeset when an invalid email is passed in attrs" do
      attrs = %{
        email: "someemail.net",
        name: "My Name",
        password: "1234"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{email: ["has invalid format"]} = errors_on(changeset)

      attrs = %{
        email: "",
        name: "My Name",
        password: "1234"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{email: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns an error and an Ecto.Changeset when an invalid name is passed in attrs" do
      attrs = %{
        email: "some@email.net",
        name: "",
        password: "1234"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns an error and an Ecto.Changeset with password error when an empty password is passed in attrs" do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: ""
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{password: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns an error and an Ecto.Changeset with password error when an invalid password is passed in attrs" do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "123"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{password: ["should be 4 character(s)"]} = errors_on(changeset)

      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "aaaa"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{password: ["Invalid format"]} = errors_on(changeset)
    end

    test "returns an error when attempting to create a user with an already used email" do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "1234"
      }

      assert {:ok, user} = Banking.create_user(attrs)
      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{email: ["has already been taken"]} = errors_on(changeset)
    end
  end

  describe "get_user/1" do
    test "returns a user when an existing id is received" do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "1234"
      }

      assert {:ok, %{id: id}} = Banking.create_user(attrs)

      assert Banking.get_user(id).id == id
    end

    test "returns nil when no user is found" do
      id = 0
      assert Banking.get_user(id) == nil
    end
  end
end
