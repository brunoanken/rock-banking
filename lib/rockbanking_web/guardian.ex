defmodule RockBankingWeb.Guardian do
  @moduledoc """
  This module contains the Guardian required functions to perform user authentication through the API.
  """
  use Guardian, otp_app: :rockbanking

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = RockBanking.Banking.get_user(id)
    {:ok, resource}
  end
end
