defmodule RockBanking.Repo.Migrations.LetsReset do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :user_id
    end
  end
end
