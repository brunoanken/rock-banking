defmodule RockBanking.Operations.SignUpBonus do
  @moduledoc """
  Contains all the operations and data manipulations related to the sign up bonus.
  """
  use Ecto.Schema
  import Ecto.{Changeset, Multi}
  alias RockBanking.Banking.User

  schema "sign_up_bonus" do
    field :amount, :float
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(sign_up_bonus, attrs) do
    sign_up_bonus
    |> cast(attrs, [:amount, :user_id])
    |> validate_required([:amount, :user_id])
    |> unique_constraint(:user_id)
    |> validate_number(:amount, greater_than: 0)
  end

  def create(user \\ %User{}, sign_up_bonus) do
    amount = 1000
    new_balance = user.balance + amount
    user_changeset = User.update_balance(user, %{balance: new_balance})
    sign_up_bonus_changeset = changeset(sign_up_bonus, %{amount: amount, user_id: user.id})

    new()
    |> insert(:sign_up_bonus, sign_up_bonus_changeset)
    |> update(:user, user_changeset)
  end
end
