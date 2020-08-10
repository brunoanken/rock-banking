defmodule RockBanking.Banking.Auth do
  @moduledoc """
  Authenticates a user via JWT by verifying the
  provided password against the user's stored password.
  """
  alias RockBanking.{Banking.User, Repo}

  def authenticate(email, password) do
    case Repo.get_by(User, email: email) do
      %User{} = user ->
        check_user_password(user, password)

      _ ->
        {:error, :invalid_user}
    end
  end

  defp check_user_password(user, password) do
    case Argon2.check_pass(user, password) do
      {:ok, _} ->
        {:ok, user}

      _ ->
        {:error, :invalid_email_and_password_combination}
    end
  end
end
