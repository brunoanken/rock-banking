defmodule RockBankingWeb.AuthControllerTest do
  use RockBankingWeb.ConnCase

  alias RockBanking.Banking
  alias RockBanking.Banking.{User, Auth}

  @user_attrs %{
    email: "email@email.mail",
    name: "My Beautiful Name",
    password: "1234"
  }

  def fixture(:user) do
    {:ok, user} = Banking.create_user(@user_attrs)
    user
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end

  describe "sign_in/2" do
    setup [:create_user]

    test "returns a 200 status with a json containing user information and a token when the
    received params are valid",
         %{conn: conn} do
      params = %{email: "email@email.mail", password: "1234"}
      conn = post(conn, Routes.auth_path(conn, :sign_in), params)
      assert %{"data" => data, "token" => token} = json_response(conn, 200)
    end
  end

  test "returns a status 401 with a json when received params are invalid", %{
    conn: conn
  } do
    params = %{email: "email@email.mail", password: "1235"}
    conn = post(conn, Routes.auth_path(conn, :sign_in), params)
    assert _ = response(conn, 401)
  end
end
