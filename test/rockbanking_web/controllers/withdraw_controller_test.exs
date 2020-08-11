defmodule RockBankingWeb.WithdrawControllerTest do
  use RockBankingWeb.ConnCase

  alias RockBanking.Operations
  alias RockBanking.Operations.Withdraw

  @create_attrs %{
    amount: 120.5
  }
  @update_attrs %{
    amount: 456.7
  }
  @invalid_attrs %{amount: nil}

  def fixture(:withdraw) do
    {:ok, withdraw} = Operations.create_withdraw(@create_attrs)
    withdraw
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all withdraws", %{conn: conn} do
      conn = get(conn, Routes.withdraw_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create withdraw" do
    test "renders withdraw when data is valid", %{conn: conn} do
      conn = post(conn, Routes.withdraw_path(conn, :create), withdraw: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.withdraw_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.withdraw_path(conn, :create), withdraw: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update withdraw" do
    setup [:create_withdraw]

    test "renders withdraw when data is valid", %{conn: conn, withdraw: %Withdraw{id: id} = withdraw} do
      conn = put(conn, Routes.withdraw_path(conn, :update, withdraw), withdraw: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.withdraw_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, withdraw: withdraw} do
      conn = put(conn, Routes.withdraw_path(conn, :update, withdraw), withdraw: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete withdraw" do
    setup [:create_withdraw]

    test "deletes chosen withdraw", %{conn: conn, withdraw: withdraw} do
      conn = delete(conn, Routes.withdraw_path(conn, :delete, withdraw))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.withdraw_path(conn, :show, withdraw))
      end
    end
  end

  defp create_withdraw(_) do
    withdraw = fixture(:withdraw)
    %{withdraw: withdraw}
  end
end
