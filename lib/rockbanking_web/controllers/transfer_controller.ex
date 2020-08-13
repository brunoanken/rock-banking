defmodule RockBankingWeb.TransferController do
  use RockBankingWeb, :controller

  alias RockBanking.Operations

  action_fallback RockBankingWeb.FallbackController

  def create(conn, params) do
    authenticated_user = Guardian.Plug.current_resource(conn)

    case Operations.create_transfer(params, authenticated_user) do
      {:ok, result} ->
        %{transfer: transfer} = result

        conn
        |> put_status(:created)
        |> render("show.json", transfer: transfer)

      _ ->
        conn
        |> put_status(422)
        |> json(%{status: "could not perform transfer"})
    end
  end
end
