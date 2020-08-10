defmodule RockBanking.Banking do
  @moduledoc """
  The Banking context.
  It is responsible to manage all users and operations related to banking.
  """

  import Ecto.Query, warn: false
  alias RockBanking.Repo
  alias RockBanking.Banking.{User, Auth}

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
    Repo.get(User, id)
  end

  @doc """
  Authenticates a user.
  """
  def sign_in(%{"email" => email, "password" => password}) do
    Auth.authenticate(email, password)
  end
end
