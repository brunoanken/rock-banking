defmodule RockBanking.Repo do
  use Ecto.Repo,
    otp_app: :rockbanking,
    adapter: Ecto.Adapters.Postgres
end
