defmodule RockBankingWeb.Guardian do
  @moduledoc """
  This module contains the Guardian required functions to perform user authentication through the API.
  """
  use Guardian, otp_app: :banking

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.user_id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    user_id = claims["sub"]
    resource = RockBanking.Banking.get_user(user_id)
    {:ok, resource}
  end
end
