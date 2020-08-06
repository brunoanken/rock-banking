defmodule RockBanking.Banking.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :balance, :float, default: 0.00, null: false
    field :email, :string, null: false, unique: true
    field :user_id, Ecto.UUID, autogenerate: true, primary_key: true
    field :name, :string, null: false
    field :password_hash, :string, null: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :id, :password_hash, :balance])
    |> validate_required([:name, :email, :id, :password_hash, :balance])
  end
end
