defmodule GoogleAuthRecipe.Repo do
  use Ecto.Repo,
    otp_app: :google_auth_recipe,
    adapter: Ecto.Adapters.Postgres
end
