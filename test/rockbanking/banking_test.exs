defmodule RockBanking.BankingTest do
  use RockBanking.DataCase

  alias RockBanking.Banking

  describe "create_user/1" do
    test "returns success and a created user when attrs passed are valid" do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "superpassw0rd"
      }

      assert {:ok, user} = Banking.create_user(attrs)
      assert user.email == "some@email.net"
      assert user.name == "My Name"
      assert user.password_hash != "superpassw0rd"
      assert user.password_hash != ""
      assert user.balance == 0
    end

    test "returns an error and an Ecto.Changeset when an invalid email is passed in attrs" do
      attrs = %{
        email: "someemail.net",
        name: "My Name",
        password: "superpassw0rd"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{email: ["has invalid format"]} = errors_on(changeset)

      attrs = %{
        email: "",
        name: "My Name",
        password: "superpassw0rd"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{email: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns an error and an Ecto.Changeset when an invalid name is passed in attrs" do
      attrs = %{
        email: "some@email.net",
        name: "",
        password: "superpassw0rd"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns an error and an Ecto.Changeset when an invalid password is passed in attrs" do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: ""
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{password: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns an error when attempting to create a user with an already used email" do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "superpassw0rd"
      }

      assert {:ok, user} = Banking.create_user(attrs)
      assert {:error, %Ecto.Changeset{} = changeset} = Banking.create_user(attrs)
      assert %{email: ["has already been taken"]} = errors_on(changeset)
    end
  end
end
