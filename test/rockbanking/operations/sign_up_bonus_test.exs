defmodule RockBanking.Operations.SignUpBonusTest do
  use RockBanking.DataCase, async: true

  alias RockBanking.Operations.SignUpBonus
  alias RockBanking.Banking

  setup do
    attrs = %{
      email: "some@email.net",
      name: "My Name",
      password: "1234"
    }

    {:ok, user} = Banking.create_user(attrs)
    %{user: user}
  end

  describe "changeset/2" do
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

  describe "create/2" do
    test "returns an ecto multi with valid operations when params are valid", %{user: user} do
      assert %Ecto.Multi{} = multi = SignUpBonus.create(user, %SignUpBonus{})
      assert multi.operations |> Enum.count() == 2

      operations_changesets_list =
        multi.operations
        |> Enum.map(fn operation ->
          RockBanking.TestHelpers.get_changeset_from_operation(operation)
        end)

      assert operations_changesets_list |> Enum.count() == 2

      assert operations_changesets_list |> Enum.all?(fn operation -> operation.valid? == true end) ==
               true
    end
  end
end
