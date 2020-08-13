defmodule RockBanking.Operations.Helpers do
  @moduledoc """
  Common functions used across different operations.
  """
  import Ecto.Changeset

  def validate_balance_after_withdraw(%Ecto.Changeset{valid?: true} = changeset, amount, balance) do
    case amount > 0 && balance - amount >= 0 do
      true -> changeset
      false -> add_error(changeset, :amount, "balance not enough for this amount")
    end
  end

  def validate_balance_after_withdraw(changeset, _, _), do: changeset
end
