defmodule GoogleAuthRecipe.Accounts.Records.User do
  @moduledoc """
  A user record.
  """

  @type t :: %__MODULE__{
          email: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  use GoogleAuthRecipe, :record

  schema "account_users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :profile_image_url, :string
    field :domain, :string, virtual: true

    timestamps()
  end

  @doc false
  def oauth_registration_changeset(user, attrs, allowed_domains, opts \\ []) do
    user
    |> cast(attrs, [:email, :first_name, :last_name, :profile_image_url, :domain])
    |> validate_required([:email, :first_name, :last_name, :profile_image_url, :domain])
    |> validate_email(opts)
    |> validate_inclusion(:domain, allowed_domains)
  end

  defp validate_email(changeset, opts) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> maybe_validate_unique_email(opts)
  end

  defp maybe_validate_unique_email(changeset, opts) do
    if Keyword.get(opts, :validate_email, true) do
      changeset
      |> unsafe_validate_unique(:email, GoogleAuthRecipe.Repo)
      |> unique_constraint(:email)
    else
      changeset
    end
  end
end
