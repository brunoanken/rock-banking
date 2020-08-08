defmodule RockBanking.Banking.UserTest do
  use RockBanking.DataCase, async: true

  alias RockBanking.Banking.User

  describe "create/2" do
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

    test "returns an ecto changeset with password error when the password param is an empty string" do
      params = %{name: "Bruno Anken", email: "brunoanken@gmail.com", password: ""}

      assert %Ecto.Changeset{} = user = User.create(%User{}, params)
      assert %{password: ["can't be blank"]} == errors_on(user)
    end

    test "returns an ecto changeset with password error when the password is not passed at all" do
      params = %{name: "Bruno Anken", email: "brunoanken@gmail.com"}

      assert %Ecto.Changeset{} = user = User.create(%User{}, params)
      assert %{password: ["can't be blank"]} = errors_on(user)
    end
  end

  describe "is_string_a_valid_integer?" do
    test "returns true when receiving a string that is a completely valid integer" do
      assert User.is_string_a_valid_integer?("1234") == true
      assert User.is_string_a_valid_integer?("1") == true
      assert User.is_string_a_valid_integer?("123423") == true
    end

    test "returns false when receiving a string that isnot a completely valid integer" do
      assert User.is_string_a_valid_integer?("123.4") == false
      assert User.is_string_a_valid_integer?("0.1") == false
      assert User.is_string_a_valid_integer?("edmar") == false
    end
  end
end
