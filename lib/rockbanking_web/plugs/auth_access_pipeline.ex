defmodule RockBankingWeb.Plugs.AuthAccessPipeline do
  @moduledoc """
  Authenticated access pipeline. Currently using Guardian.
  """

  use Guardian.Plug.Pipeline,
    otp_app: :rockbanking,
    module: RockBankingWeb.Guardian,
    error_handler: RockBankingWeb.Plugs.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
