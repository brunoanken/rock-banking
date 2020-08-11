defmodule RockBanking.Repo.Migrations.CreateWithdraws do
  use Ecto.Migration

  def change do
    create table(:withdraws) do
      add :amount, :float
      add :user_id, references(:users, on_delete: :nothing), null: false, unique: true

      timestamps()
    end

    create index(:withdraws, [:user_id])
  end
end
