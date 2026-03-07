defmodule GoogleAuthRecipe do
  @moduledoc """
  A recipe for authentication with Google.
  """

  @doc """
  For shared application module configuration.
  """
  def application do
    quote do
      alias Adwell.Repo
      alias Adwell.Scope

      alias Adwell.Infrastructure.Clock
    end
  end

  @doc """
  For shared record and schema configuration.
  """
  def record do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @timestamps_opts [type: :utc_datetime_usec]
    end
  end

  @doc """
  When used, dispatch to the appropriate record/application/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
