defmodule RockBanking.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false, unique: true
      add :user_id, :uuid, autogenerate: true, primary_key: true
      add :password_hash, :string, null: false
      add :balance, :float, default: 0.00, null: false

      timestamps()
    end

    create constraint("users", :balance_must_not_be_negative, check: "balance >= 0")
  end
end
