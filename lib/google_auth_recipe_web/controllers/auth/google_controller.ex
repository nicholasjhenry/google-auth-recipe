defmodule GoogleAuthRecipeWeb.Auth.GoogleController do
  use GoogleAuthRecipeWeb, :controller

  plug Ueberauth

  alias GoogleAuthRecipe.Accounts.Application.Users
  alias GoogleAuthRecipe.Accounts.Records.User
  alias GoogleAuthRecipeWeb.Auth.UserAuth

  def request(conn, _params) do
    Phoenix.Controller.redirect(conn, to: ~p"/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case Users.get_user_by_email(auth.info.email) do
      %User{} = user ->
        log_in_user(conn, user, params)

      nil ->
        register_and_log_in_user(conn, auth.info, params)
    end
  end

  defp register_and_log_in_user(conn, auth_info, params) do
    domain = Map.fetch!(auth_info.urls, :website) || get_domain(auth_info.email)

    user_params =
      %{
        email: auth_info.email,
        first_name: auth_info.first_name,
        last_name: auth_info.last_name,
        profile_image_url: auth_info.image,
        domain: domain
      }

    case Users.register_oauth_user(user_params) do
      {:ok, user} ->
        log_in_user(conn, user, params)

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Failed to register your account, please contact the Administrator.")
        |> redirect(to: ~p"/")
    end
  end

  defp log_in_user(conn, user, params) do
    conn
    |> put_flash(:info, "Welcome back!")
    |> UserAuth.log_in_user(user, params)
  end

  defp get_domain(email) do
    [_alias, domain] = String.split(email, "@")
    domain
  end
end
