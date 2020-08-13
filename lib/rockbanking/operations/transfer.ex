defmodule RockBanking.Operations.Transfer do
  use Ecto.Schema
  import Ecto.{Changeset, Multi}
  import RockBanking.Operations.Helpers

  alias RockBanking.Banking.User

  schema "transfers" do
    field :amount, :float
    belongs_to :from_user, User, foreign_key: :from_user_id
    belongs_to :to_user, User, foreign_key: :to_user_id

    timestamps()
  end

  @doc false
  def create_changeset(transfer, attrs, user) do
    %{"amount" => amount, "to_user_id" => to_user_id} = attrs
    %User{balance: from_user_balance, id: from_user_id} = user

    transfer
    |> cast(attrs, [:amount, :to_user_id])
    |> put_change(:from_user_id, from_user_id)
    |> validate_required([:amount, :to_user_id, :from_user_id])
    |> validate_number(:amount, greater_than: 0)
    |> validate_balance_after_withdraw(amount, from_user_balance)
    |> validate_different_users(to_user_id, from_user_id)
  end

  def create(withdraw, attrs, from_user, to_user) do
    %{"amount" => amount} = attrs
    %User{balance: from_user_balance} = from_user
    %User{balance: to_user_balance} = to_user

    new_from_user_balance = from_user_balance - amount
    new_to_user_balance = to_user_balance + amount

    new()
    |> insert(:transfer, create_changeset(withdraw, attrs, from_user))
    |> update(:from_user, User.update_balance(from_user, %{balance: new_from_user_balance}))
    |> update(:to_user, User.update_balance(to_user, %{balance: new_to_user_balance}))
  end

  def validate_different_users(
        %Ecto.Changeset{valid?: true} = changeset,
        to_user_id,
        from_user_id
      ) do
    case different_users?(to_user_id, from_user_id) do
      true -> changeset
      false -> add_error(changeset, :to_user_id, "cannot transfer to the same user")
    end
  end

  def validate_different_users(changeset, _, _), do: changeset

  def different_users?(to_user_id, from_user_id) do
    to_user_id != from_user_id
  end
end
