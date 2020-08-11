defmodule RockBanking.Operations do
  @moduledoc """
  The Operations context.
  """

  import Ecto.Query, warn: false
  alias RockBanking.Repo

  alias RockBanking.Operations.SignUpBonus

  @doc """
  Creates a sign_up_bonus.
  """
  def create_sign_up_bonus(user) do
    user
    |> SignUpBonus.create(%SignUpBonus{})
    |> Repo.transaction()
  end

  alias RockBanking.Operations.Withdraw

  @doc """
  Creates a withdraw.
  """
  def create_withdraw(attrs \\ %{}, user) do
    %Withdraw{}
    |> Withdraw.create(attrs, user)
    |> Repo.transaction()
  end
end
