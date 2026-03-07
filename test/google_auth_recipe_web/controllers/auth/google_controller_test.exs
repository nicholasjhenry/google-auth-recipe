defmodule GoogleAuthRecipeWeb.GoogleControllerTest do
  use GoogleAuthRecipeWeb.ConnCase

  alias GoogleAuthRecipeWeb.Auth.Controls

  import GoogleAuthRecipe.AccountFixtures

  describe "GET /auth/google/callback" do
    test "given no existing user; registers and logs the user in", %{conn: conn} do
      conn = assign(conn, :ueberauth_auth, Controls.Ueberauth.Auth.example())

      conn = get(conn, ~p"/auth/google/callback", %{})

      assert get_session(conn, :user_token)
      assert redirected_to(conn) == ~p"/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, ~p"/")
      response = html_response(conn, 200)
      assert response =~ "Sign out"
    end

    test "given an existing user; logs the user in", %{conn: conn} do
      user = user_fixture()
      auth_control = Controls.Ueberauth.Auth.example()
      info = %{auth_control.info | email: user.email}
      conn = assign(conn, :ueberauth_auth, %{auth_control | info: info})

      conn = get(conn, ~p"/auth/google/callback", %{})

      assert get_session(conn, :user_token)
      assert redirected_to(conn) == ~p"/"

      # Now do a logged in request and assert on the menu
      conn = get(conn, ~p"/")
      response = html_response(conn, 200)
      assert response =~ "Sign out"
    end

    test "logs the user in with return to", %{conn: conn} do
      conn = assign(conn, :ueberauth_auth, Controls.Ueberauth.Auth.example())

      conn =
        conn
        |> init_test_session(user_return_to: "/foo/bar")
        |> get(~p"/auth/google/callback", %{})

      assert redirected_to(conn) == "/foo/bar"
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Welcome back!"
    end

    test "emits error when user registration fails", %{conn: conn} do
      auth_control = Controls.Ueberauth.Auth.example()
      info = %{auth_control.info | first_name: nil}
      conn = assign(conn, :ueberauth_auth, %{auth_control | info: info})

      conn = get(conn, ~p"/auth/google/callback", %{})

      assert redirected_to(conn) == ~p"/"
      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~ "Failed to register"
    end
  end
end
