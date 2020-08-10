defmodule RockBankingWeb.AuthController do
  use RockBankingWeb, :controller

  alias RockBanking.Banking
  alias RockBankingWeb.Guardian

  action_fallback RockBankingWeb.FallbackController

  def sign_in(conn, params) do
    with {:ok, user} <- Banking.sign_in(params),
         {:ok, token, _} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("show.json", %{user: user, token: token})
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{message: "wrong email and password combination"})
    end
  end
end
