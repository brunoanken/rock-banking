defmodule RockBanking.Operations.Withdraw do
  use Ecto.Schema
  import Ecto.{Changeset, Multi}

  alias RockBanking.Banking.User

  schema "withdraws" do
    field :amount, :float
    belongs_to :user, User

    timestamps()
  end

  def create_changeset(withdraw, attrs, user) do
    IO.puts("changeset")
    %{"amount" => amount} = attrs
    %User{balance: balance, id: user_id} = user
    IO.puts(user_id)

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
    IO.puts("create withdraw.ex")

    %{"amount" => amount} = attrs
    %User{balance: balance} = user

    new_balance = balance - amount
    withdraw_changeset = create_changeset(withdraw, attrs, user)
    user_changeset = User.update_balance(user, %{balance: new_balance})

    new()
    |> insert(:withdraw, withdraw_changeset)
    |> update(:user, user_changeset)
  end

  def validate_balance_after_withdraw(%Ecto.Changeset{valid?: true} = changeset, amount, balance) do
    case amount > 0 && balance - amount >= 0 do
      true -> changeset
      false -> add_error(changeset, :amount, "balance not enough for this amount")
    end
  end

  def validate_balance_after_withdraw(changeset, _, _), do: changeset
end
