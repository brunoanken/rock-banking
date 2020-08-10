defmodule RockBankingWeb.UserControllerTest do
  use RockBankingWeb.ConnCase

  @valid_attrs %{
    email: "email@email.mail",
    name: "My Beautiful Name",
    password: "1234"
  }
  @invalid_attrs %{email: nil, name: nil, password: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "sign_up/1" do
    test "returns the user json with 201 status code when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :sign_up), @valid_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "returns an error json with 422 status when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :sign_up), @invalid_attrs)
      assert _ = response(conn, 422)
    end
  end
end
