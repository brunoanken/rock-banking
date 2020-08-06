defmodule RockBanking.Banking do
  @moduledoc """
  The Banking context.
  """

  import Ecto.Query, warn: false
  alias RockBanking.Repo

  alias RockBanking.Banking.User

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.create(attrs)
    |> Repo.insert()
  end
end
