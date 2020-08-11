defmodule RockBankingWeb.WithdrawController do
  use RockBankingWeb, :controller

  alias RockBanking.Operations
  alias RockBanking.Operations.Withdraw
  alias RockBanking.Banking.User

  action_fallback RockBankingWeb.FallbackController

  def create(conn, params) do
    authenticated_user = Guardian.Plug.current_resource(conn)

    case Operations.create_withdraw(params, authenticated_user) do
      {:ok, result} ->
        %{withdraw: withdraw} = result

        conn
        |> put_status(:created)
        |> render("show.json", withdraw: withdraw)

      _ ->
        conn
        |> put_status(422)
        |> json(%{status: "could not perform withdraw"})
    end
  end
end
