defmodule RockBanking.Operations.Withdraw do
  use Ecto.Schema
  import Ecto.{Changeset, Multi}
  import RockBanking.Operations.Helpers

  alias RockBanking.Banking.User

  schema "withdraws" do
    field :amount, :float
    belongs_to :user, User

    timestamps()
  end

  def create_changeset(withdraw, attrs, user) do
    %{"amount" => amount} = attrs
    %User{balance: balance, id: user_id} = user

    withdraw
    |> cast(attrs, [:amount])
    |> put_change(:user_id, user_id)
    |> validate_required([:amount, :user_id])
    |> unique_constraint(:user_id)
    |> validate_number(:amount, greater_than: 0)
    |> validate_balance_after_withdraw(amount, balance)
  end

  @doc false
  def create(withdraw, attrs, user) do
    %{"amount" => amount} = attrs
    %User{balance: balance} = user

    new_balance = balance - amount
    withdraw_changeset = create_changeset(withdraw, attrs, user)
    user_changeset = User.update_balance(user, %{balance: new_balance})

    new()
    |> insert(:withdraw, withdraw_changeset)
    |> update(:user, user_changeset)
  end
end
