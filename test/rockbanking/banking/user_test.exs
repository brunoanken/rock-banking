defmodule RockBanking.Banking.UserTest do
  use RockBanking.DataCase, async: true

  alias RockBanking.Banking
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

  describe "validate_password/1" do
    test "returns the same changeset when the password change is present in the changeset and it is a valid integer" do
      user_changeset = %Ecto.Changeset{valid?: true, changes: %{password: "1234"}}

      assert User.validate_password(user_changeset) == user_changeset
    end

    test "returns a changeset with a password error when the changeset passed to it has a password that is not a valid integer" do
      user_changeset = %Ecto.Changeset{valid?: true, changes: %{password: "12.4"}}

      assert %Ecto.Changeset{errors: [password: {"Invalid format", []}]} =
               User.validate_password(user_changeset)

      user_changeset = %Ecto.Changeset{valid?: true, changes: %{password: "aaaa"}}

      assert %Ecto.Changeset{errors: [password: {"Invalid format", []}]} =
               User.validate_password(user_changeset)

      user_changeset = %Ecto.Changeset{valid?: true, changes: %{password: ""}}

      assert %Ecto.Changeset{errors: [password: {"Invalid format", []}]} =
               User.validate_password(user_changeset)
    end
  end

  describe "update_balance/1" do
    setup do
      attrs = %{
        email: "some@email.net",
        name: "My Name",
        password: "1234",
        id: 42
      }

      {:ok, user} = Banking.create_user(attrs)
      %{user: user}
    end

    test "returns a valid ecto changeset when params are valid", %{user: user} do
      assert %Ecto.Changeset{valid?: true, changes: %{balance: 1000.00}} =
               User.update_balance(user, %{balance: 1000.00})

      assert %Ecto.Changeset{valid?: true} = User.update_balance(user, %{balance: 0.00})
    end

    test "rturns an invalid ecto changeset when params are invalid", %{user: user} do
      assert %Ecto.Changeset{valid?: false, changes: %{balance: -0.01}} =
               user_changeset = User.update_balance(user, %{balance: -0.01})

      assert %{balance: ["must be greater than or equal to 0"]} = errors_on(user_changeset)

      assert %Ecto.Changeset{valid?: false, changes: %{balance: -1.0}} =
               user_changeset = User.update_balance(user, %{balance: -1})

      assert %{balance: ["must be greater than or equal to 0"]} = errors_on(user_changeset)
    end
  end
end
