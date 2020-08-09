defmodule RockBankingWeb.Plugs.AuthErrorHandler do
  @moduledoc """
  Authenticated access error pipeline. Currently using guardian.
  """
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  @spec auth_error(Plug.Conn.t(), {any, any}, any) :: Plug.Conn.t()
  def auth_error(conn, {type, _reason}, _opts) do
    body = Phoenix.json_library().encode!(%{message: to_string(type)})
    IO.puts("chegou aqui")

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
