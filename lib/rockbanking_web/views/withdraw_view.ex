defmodule RockBankingWeb.WithdrawView do
  use RockBankingWeb, :view
  alias RockBankingWeb.WithdrawView

  def render("index.json", %{withdraws: withdraws}) do
    %{data: render_many(withdraws, WithdrawView, "withdraw.json")}
  end

  def render("show.json", %{withdraw: withdraw}) do
    %{data: render_one(withdraw, WithdrawView, "withdraw.json")}
  end

  def render("withdraw.json", %{withdraw: withdraw}) do
    %{
      amount: withdraw.amount
    }
  end
end
