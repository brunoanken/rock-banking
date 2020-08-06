defmodule RockBanking.Banking.UserTest do
  use RockBanking.DataCase, async: true
  alias RockBanking.Banking.User

  describe "create" do
    test "returns an ecto changeset without errors when params are valid" do
      params = %{name: "Bruno Anken", email: "brunoanken@gmail.com", password: "1234"}

      assert %Ecto.Changeset{} = user = User.create(%User{}, params)
      assert %{} == errors_on(user)

      assert "brunoanken@gmail.com" = get_change(user, :email)
      assert "Bruno Anken" = get_change(user, :name)

      assert get_change(user, :password_hash) != ""
      assert get_change(user, :password_hash) != "1234"
    end

    test "returns an ecto changeset with email error when the email param is invalid" do
      params = %{name: "Bruno Anken", email: "brunoankengmail.com", password: "1234"}
      assert %Ecto.Changeset{} = user = User.create(%User{}, params)
      assert %{email: ["has invalid format"]} == errors_on(user)

      params = %{name: "Bruno Anken", email: "", password: "1234"}
      assert %Ecto.Changeset{} = user = User.create(%User{}, params)
      assert %{email: ["can't be blank"]} == errors_on(user)
    end

    test "returns an ecto changeset with name error when the name param is invalid" do
      params = %{name: "", email: "brunoanken@gmail.com", password: "1234"}

      assert %Ecto.Changeset{} = user = User.create(%User{}, params)
      assert %{name: ["can't be blank"]} == errors_on(user)
    end

    test "returns an ecto changeset with password error when the password param is invalid" do
      params = %{name: "Bruno Anken", email: "brunoanken@gmail.com", password: ""}

      assert %Ecto.Changeset{} = user = User.create(%User{}, params)
      assert %{password: ["can't be blank"]} == errors_on(user)
    end
  end
end
