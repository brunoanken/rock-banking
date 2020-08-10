defmodule RockBanking.Operations.SignUpBonusTest do
  use RockBanking.DataCase, async: true

  alias RockBanking.Operations.SignUpBonus
  alias RockBanking.Banking

  describe "changeset/2" do
    setup do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "1234"
      }

      {:ok, user} = Banking.create_user(attrs)
      %{user: user}
    end

    test "returns a valid ecto changeset when params are valid", %{user: user} do
      params = %{amount: 1000.00, user_id: user.id}

      assert %Ecto.Changeset{valid?: true, changes: %{amount: 1000.00}} =
               sign_up_bonus = SignUpBonus.changeset(%SignUpBonus{}, params)
    end

    test "returns an invalid ecto changeset when params are invalid", %{user: user} do
      assert %Ecto.Changeset{valid?: false} =
               sign_up_bonus =
               SignUpBonus.changeset(%SignUpBonus{}, %{amount: 0.00, user_id: user.id})

      assert %{amount: ["must be greater than 0"]} = errors_on(sign_up_bonus)

      assert %Ecto.Changeset{valid?: false} =
               sign_up_bonus =
               SignUpBonus.changeset(%SignUpBonus{}, %{amount: 1000.00, user_id: "randomid"})

      assert %{user_id: ["is invalid"]} = errors_on(sign_up_bonus)
    end
  end
end
