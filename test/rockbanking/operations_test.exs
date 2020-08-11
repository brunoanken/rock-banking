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

    @valid_attrs %{amount: 120.5}
    @update_attrs %{amount: 456.7}
    @invalid_attrs %{amount: nil}

    def withdraw_fixture(attrs \\ %{}) do
      {:ok, withdraw} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Operations.create_withdraw()

      withdraw
    end

    test "list_withdraws/0 returns all withdraws" do
      withdraw = withdraw_fixture()
      assert Operations.list_withdraws() == [withdraw]
    end

    test "get_withdraw!/1 returns the withdraw with given id" do
      withdraw = withdraw_fixture()
      assert Operations.get_withdraw!(withdraw.id) == withdraw
    end

    test "create_withdraw/1 with valid data creates a withdraw" do
      assert {:ok, %Withdraw{} = withdraw} = Operations.create_withdraw(@valid_attrs)
      assert withdraw.amount == 120.5
    end

    test "create_withdraw/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Operations.create_withdraw(@invalid_attrs)
    end

    test "update_withdraw/2 with valid data updates the withdraw" do
      withdraw = withdraw_fixture()
      assert {:ok, %Withdraw{} = withdraw} = Operations.update_withdraw(withdraw, @update_attrs)
      assert withdraw.amount == 456.7
    end

    test "update_withdraw/2 with invalid data returns error changeset" do
      withdraw = withdraw_fixture()
      assert {:error, %Ecto.Changeset{}} = Operations.update_withdraw(withdraw, @invalid_attrs)
      assert withdraw == Operations.get_withdraw!(withdraw.id)
    end

    test "delete_withdraw/1 deletes the withdraw" do
      withdraw = withdraw_fixture()
      assert {:ok, %Withdraw{}} = Operations.delete_withdraw(withdraw)
      assert_raise Ecto.NoResultsError, fn -> Operations.get_withdraw!(withdraw.id) end
    end

    test "change_withdraw/1 returns a withdraw changeset" do
      withdraw = withdraw_fixture()
      assert %Ecto.Changeset{} = Operations.change_withdraw(withdraw)
    end
  end
end
