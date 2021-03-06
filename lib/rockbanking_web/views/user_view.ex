defmodule RockBankingWeb.UserView do
  use RockBankingWeb, :view
  alias RockBankingWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      name: user.name,
      email: user.email,
      id: user.id,
      balance: user.balance
    }
  end
end
