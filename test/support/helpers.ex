defmodule RockBanking.TestHelpers do
  @moduledoc """
  Helper functions that canbe used across some different test suites.
  """
  def get_changeset_from_operation({_, tuple}) do
    {:changeset, changeset, _} = tuple
    changeset
  end
end
