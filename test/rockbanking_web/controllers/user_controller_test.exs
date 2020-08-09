defmodule RockBankingWeb.UserControllerTest do
  use RockBankingWeb.ConnCase

  alias RockBanking.Banking
  alias RockBanking.Banking.User

  @valid_attrs %{
    email: "email@email.mail",
    name: "My Beautiful Name",
    password: "1234"
  }
  @invalid_attrs %{email: nil, name: nil, password: nil}

  def fixture(:user) do
    {:ok, user} = Banking.create_user(@valid_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end

  describe "sign_up/1" do
    test "returns the user json with 201 status code when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :sign_up), @valid_attrs)
      assert %{"user_id" => user_id} = json_response(conn, 201)["data"]
    end

    test "returns an error json with 422 status when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :sign_up), @invalid_attrs)
      assert _ = response(conn, 422)
    end
  end
end
