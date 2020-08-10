defmodule RockBanking.Repo.Migrations.CreateSignUpBonus do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :id, :id, unique: true, primary_key: true
    end

    create table(:sign_up_bonus) do
      add :amount, :float
      add :user_id, references(:users, on_delete: :nothing), null: false, unique: true

      timestamps()
    end

    create unique_index(:sign_up_bonus, [:user_id])
  end
end
