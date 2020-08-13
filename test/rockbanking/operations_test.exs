defmodule RockBanking.OperationsTest do
  use RockBanking.DataCase

  alias RockBanking.Operations
  alias RockBanking.Banking

  describe "create_sign_up_bonus/1" do
    alias RockBanking.Operations.SignUpBonus
    alias RockBanking.Banking.User

    setup do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "1234"
      }

      {:ok, user} = Banking.create_user(attrs)
      %{user: user}
    end

    test "creates a sign up bonus operation and updates the user table with the user's new balance when a valid user is received",
         %{user: user} do
      assert {:ok, data} = Operations.create_sign_up_bonus(user)
      assert %{sign_up_bonus: %SignUpBonus{}, user: %User{}} = data
    end

    test "fails when an invalid user is received" do
      assert_raise UndefinedFunctionError, fn ->
        Operations.create_sign_up_bonus(nil)
      end
    end
  end

  describe "withdraws" do
    alias RockBanking.Operations.Withdraw
  end

  describe "transfers" do
    alias RockBanking.Operations.Transfer
  end
end
