defmodule RockBanking.Banking do
  @moduledoc """
  The Banking context. It is responsible to manage all users and operations related to banking.
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

  @doc """
  Gets a user by ID.
  """
  def get_user(id) do
    %User{}
    |> Repo.get(id)
  end
end
