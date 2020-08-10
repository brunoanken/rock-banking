defmodule RockBanking.TestHelpers do
  def get_changeset_from_operation({_, tuple}) do
    {:changeset, changeset, _} = tuple
    changeset
  end
end
