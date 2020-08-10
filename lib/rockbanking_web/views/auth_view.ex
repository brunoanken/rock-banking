defmodule RockBankingWeb.AuthView do
  use RockBankingWeb, :view
  alias RockBankingWeb.UserView

  def render("show.json", %{user: user, token: token}) do
    %{data: UserView.render("user.json", %{user: user}), token: token}
  end
end
