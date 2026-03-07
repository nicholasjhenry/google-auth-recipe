defmodule GoogleAuthRecipe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GoogleAuthRecipeWeb.Telemetry,
      GoogleAuthRecipe.Repo,
      {DNSCluster,
       query: Application.get_env(:google_auth_recipe, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GoogleAuthRecipe.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GoogleAuthRecipe.Finch},
      # Start a worker by calling: GoogleAuthRecipe.Worker.start_link(arg)
      # {GoogleAuthRecipe.Worker, arg},
      # Start to serve requests, typically the last entry
      GoogleAuthRecipeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoogleAuthRecipe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GoogleAuthRecipeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
