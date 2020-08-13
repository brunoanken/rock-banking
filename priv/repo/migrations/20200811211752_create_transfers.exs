defmodule RockBanking.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :amount, :float
      add :from_user_id, references(:users, on_delete: :nothing), null: false
      add :to_user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:transfers, [:from_user_id])
    create index(:transfers, [:to_user_id])
  end
end
