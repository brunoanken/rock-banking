defmodule RockBankingWeb.TransferView do
  use RockBankingWeb, :view
  alias RockBankingWeb.TransferView

  def render("index.json", %{transfers: transfers}) do
    %{data: render_many(transfers, TransferView, "transfer.json")}
  end

  def render("show.json", %{transfer: transfer}) do
    %{data: render_one(transfer, TransferView, "transfer.json")}
  end

  def render("transfer.json", %{transfer: transfer}) do
    %{id: transfer.id,
      amount: transfer.amount}
  end
end
