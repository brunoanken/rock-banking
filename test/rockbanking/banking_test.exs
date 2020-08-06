defmodule RockBanking.BankingTest do
  use RockBanking.DataCase

  alias RockBanking.Banking

  describe "users" do
    alias RockBanking.Banking.User

    @valid_attrs %{
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

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Banking.create_user()

      user
    end
  end
end
