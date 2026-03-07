defmodule GoogleAuthRecipeWeb.Auth.UserSessionControllerTest do
  use GoogleAuthRecipeWeb.ConnCase, async: true

  import GoogleAuthRecipe.AccountFixtures

  setup do
    %{user: user_fixture()}
  end

  describe "GET /users/log_in" do
    test "renders log in page", %{conn: conn} do
      conn = get(conn, ~p"/auth/log_in")
      response = html_response(conn, 200)
      assert response =~ "Sign in"
    end

    test "redirects if already logged in", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> get(~p"/auth/log_in")
      assert redirected_to(conn) == ~p"/"
    end
  end

  describe "DELETE /auth/log_out" do
    test "logs the user out", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> delete(~p"/auth/log_out")
      assert redirected_to(conn) == ~p"/"
      refute get_session(conn, :user_token)
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Logged out successfully"
    end

    test "succeeds even if the user is not logged in", %{conn: conn} do
      conn = delete(conn, ~p"/auth/log_out")
      assert redirected_to(conn) == ~p"/"
      refute get_session(conn, :user_token)
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Logged out successfully"
    end
  end
end
