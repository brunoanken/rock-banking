defmodule RockBanking.BankingTest do
  use RockBanking.DataCase

  alias RockBanking.Banking
  alias RockBanking.Banking.{User}

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

  describe "sign_in/1" do
    test "returns an :ok and a user when a valid combination of user and password are received" do
      email = "some@email.net"
      name = "My Name"
      password = "1234"

      attrs = %{
        email: email,
        name: name,
        password: password
      }

      assert {:ok, %User{}} = Banking.create_user(attrs)
      assert {:ok, %User{} = user} = Banking.sign_in(%{"email" => email, "password" => password})
      assert user.email == email
      assert user.name == name
    end

    test "returns an :error and a message when an invalid combination of user and password are received" do
      email = "some@email.net"
      name = "My Name"
      password = "1234"

      attrs = %{
        email: email,
        name: name,
        password: password
      }

      assert {:ok, %User{}} = Banking.create_user(attrs)

      some_email = "wrong@email.net"
      some_password = "5678"

      assert {:error, :invalid_email_and_password_combination} =
               Banking.sign_in(%{"email" => email, "password" => some_password})

      assert {:error, :invalid_user} =
               Banking.sign_in(%{"email" => some_email, "password" => password})

      assert {:error, :invalid_user} =
               Banking.sign_in(%{"email" => some_email, "password" => some_password})
    end
  end
end
