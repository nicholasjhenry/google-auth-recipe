defmodule GoogleAuthRecipeWeb.Auth.UserSessionController do
  use GoogleAuthRecipeWeb, :controller

  alias GoogleAuthRecipeWeb.Auth.UserAuth

  def new(conn, _params) do
    conn
    |> put_layout(html: {GoogleAuthRecipeWeb.Layouts, :root})
    |> render(:new, page_title: "Sign in", error_message: nil)
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
