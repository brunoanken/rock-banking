defmodule RockBankingWeb.UserController do
  use RockBankingWeb, :controller

  alias RockBanking.Banking
  alias RockBanking.Banking.User

  action_fallback RockBankingWeb.FallbackController

  def sign_up(conn, params) do
    with {:ok, user} <- Banking.create_user(params) do
      conn
      |> put_status(:created)
      |> render("show.json", %{user: user})
    else
      _ ->
        conn
        |> put_status(422)
        |> json(%{status: "could not create user"})
    end
  end
end
