defmodule RockBankingWeb.Router do
  use RockBankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug RockBankingWeb.Plugs.AuthAccessPipeline
  end

  scope "/api/v1", RockBankingWeb do
    pipe_through :api

    post("/users/sign_up", UserController, :sign_up)
    post("/users/sign_in", AuthController, :sign_in)
  end

  scope "/api/v1/operations", RockBankingWeb do
    pipe_through [:api, :authenticated]

    post("/withdraw", WithdrawController, :create)
    post("/transfer", TransferController, :create)
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RockBankingWeb.Telemetry
    end
  end
end
