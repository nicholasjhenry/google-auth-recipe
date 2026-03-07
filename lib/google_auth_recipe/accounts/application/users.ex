defmodule GoogleAuthRecipe.Accounts.Application.Users do
  @moduledoc """
  Application logic for user management.
  """

  alias GoogleAuthRecipe.Repo

  alias GoogleAuthRecipe.Accounts.Records.User
  alias GoogleAuthRecipe.Accounts.Records.UserToken

  @spec get_user_by_email(String.t()) :: User.t() | nil
  def get_user_by_email(email) when is_binary(email) do
    Repo.get_by(User, email: email)
  end

  def get_user_by_session_token(token) do
    {:ok, query} = UserToken.verify_session_token_query(token)
    Repo.one(query)
  end

  def delete_user_session_token(token) do
    Repo.delete_all(UserToken.by_token_and_context_query(token, "session"))
    :ok
  end

  def register_oauth_user(attrs) do
    %User{}
    |> User.oauth_registration_changeset(attrs, allowed_domains())
    |> Repo.insert()
  end

  def generate_user_session_token(user) do
    {token, user_token} = UserToken.build_session_token(user)
    Repo.insert!(user_token)
    token
  end

  def allowed_domains do
    Application.fetch_env!(:ueberauth, Ueberauth.Strategy.Google.OAuth)
    |> Keyword.fetch!(:allowed_domains)
    |> String.split(",")
  end
end
