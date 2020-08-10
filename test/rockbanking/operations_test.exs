defmodule RockBanking.OperationsTest do
  use RockBanking.DataCase

  alias RockBanking.Operations

  describe "sign_up_bonus" do
    alias RockBanking.Operations.SignUpBonus

    @valid_attrs %{amount: 120.5}
    @update_attrs %{amount: 456.7}
    @invalid_attrs %{amount: nil}

    def sign_up_bonus_fixture(attrs \\ %{}) do
      {:ok, sign_up_bonus} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Operations.create_sign_up_bonus()

      sign_up_bonus
    end

    test "list_sign_up_bonus/0 returns all sign_up_bonus" do
      sign_up_bonus = sign_up_bonus_fixture()
      assert Operations.list_sign_up_bonus() == [sign_up_bonus]
    end

    test "get_sign_up_bonus!/1 returns the sign_up_bonus with given id" do
      sign_up_bonus = sign_up_bonus_fixture()
      assert Operations.get_sign_up_bonus!(sign_up_bonus.id) == sign_up_bonus
    end

    test "create_sign_up_bonus/1 with valid data creates a sign_up_bonus" do
      assert {:ok, %SignUpBonus{} = sign_up_bonus} = Operations.create_sign_up_bonus(@valid_attrs)
      assert sign_up_bonus.amount == 120.5
    end

    test "create_sign_up_bonus/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Operations.create_sign_up_bonus(@invalid_attrs)
    end

    test "update_sign_up_bonus/2 with valid data updates the sign_up_bonus" do
      sign_up_bonus = sign_up_bonus_fixture()
      assert {:ok, %SignUpBonus{} = sign_up_bonus} = Operations.update_sign_up_bonus(sign_up_bonus, @update_attrs)
      assert sign_up_bonus.amount == 456.7
    end

    test "update_sign_up_bonus/2 with invalid data returns error changeset" do
      sign_up_bonus = sign_up_bonus_fixture()
      assert {:error, %Ecto.Changeset{}} = Operations.update_sign_up_bonus(sign_up_bonus, @invalid_attrs)
      assert sign_up_bonus == Operations.get_sign_up_bonus!(sign_up_bonus.id)
    end

    test "delete_sign_up_bonus/1 deletes the sign_up_bonus" do
      sign_up_bonus = sign_up_bonus_fixture()
      assert {:ok, %SignUpBonus{}} = Operations.delete_sign_up_bonus(sign_up_bonus)
      assert_raise Ecto.NoResultsError, fn -> Operations.get_sign_up_bonus!(sign_up_bonus.id) end
    end

    test "change_sign_up_bonus/1 returns a sign_up_bonus changeset" do
      sign_up_bonus = sign_up_bonus_fixture()
      assert %Ecto.Changeset{} = Operations.change_sign_up_bonus(sign_up_bonus)
    end
  end
end
