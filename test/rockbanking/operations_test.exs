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
  end
end
