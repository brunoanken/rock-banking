defmodule RockBanking.Banking.AuthTest do
  use RockBanking.DataCase, async: true

  alias RockBanking.Banking
  alias RockBanking.Banking.{Auth, User}

  describe "authenticate/2" do
    test "returns an :ok and a user when a valid combination of user and password are received" do
      email = "some@email.net"
      password = "1234"

      attrs = %{
        email: email,
        name: "My Name",
        password: password
      }

      assert {:ok, %User{}} = Banking.create_user(attrs)
      assert {:ok, %User{}} = Auth.authenticate(email, password)
    end

    test "returns an :error and a message when an invalid combination of user and password are received" do
      email = "some@email.net"
      password = "1234"

      attrs = %{
        email: email,
        name: "My Name",
        password: password
      }

      assert {:ok, %User{}} = Banking.create_user(attrs)

      some_email = "wrong@email.net"
      some_password = "5678"

      assert {:error, :invalid_user} = Auth.authenticate(some_email, password)

      assert {:error, :invalid_email_and_password_combination} =
               Auth.authenticate(email, some_password)
    end
  end
end
