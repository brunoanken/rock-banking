defmodule RockBankingWeb.UserControllerTest do
  use RockBankingWeb.ConnCase

  alias RockBanking.Banking
  alias RockBanking.Banking.User

  @create_attrs %{
    balance: 120.5,
    email: "some email",
    id: "7488a646-e31f-11e4-aace-600308960662",
    name: "some name",
    password_hash: "some password_hash"
  }
  @update_attrs %{
    balance: 456.7,
    email: "some updated email",
    id: "7488a646-e31f-11e4-aace-600308960668",
    name: "some updated name",
    password_hash: "some updated password_hash"
  }
  @invalid_attrs %{balance: nil, email: nil, id: nil, name: nil, password_hash: nil}

  def fixture(:user) do
    {:ok, user} = Banking.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
