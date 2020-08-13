defmodule RockBanking.Operations do
  @moduledoc """
  The Operations context.
  """

  import Ecto.Query, warn: false
  import RockBanking.Banking

  alias RockBanking.Repo
  alias RockBanking.Operations.SignUpBonus
  alias RockBanking.Operations.Transfer
  alias RockBanking.Banking.User

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

  @doc """
  Creates a transfer.

  """
  def create_transfer(attrs \\ %{}, from_user) do
    %{"to_user_id" => to_user_id} = attrs

    case get_user(to_user_id) do
      %User{} = to_user ->
        %Transfer{}
        |> Transfer.create(attrs, from_user, to_user)
        |> Repo.transaction()

      nil ->
        nil
    end
  end
end
