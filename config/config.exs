# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rockbanking,
  namespace: RockBanking,
  ecto_repos: [RockBanking.Repo]

# Configures the endpoint
config :rockbanking, RockBankingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6xuo80mbeKdls7P+o7GW3PrXTV2jXhHu8/1oabpYS7gYlcIGsqt+t5WM3V9GFtn8",
  render_errors: [view: RockBankingWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: RockBanking.PubSub,
  live_view: [signing_salt: "VzLzHFt9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :rockbanking, RockBankingWeb.Guardian,
  issuer: "rockbanking",
  secret_key: "UIfxJSqAF52vUZHqs4J4/MNrgbRyyOEjtt895ezSRO8itkn7ZSDNJm+OYBgoZC9o"
