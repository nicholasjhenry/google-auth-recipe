defmodule GoogleAuthRecipeWeb.Router do
  use GoogleAuthRecipeWeb, :router

  import GoogleAuthRecipeWeb.Auth.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {GoogleAuthRecipeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GoogleAuthRecipeWeb do
    pipe_through [:browser]

    get "/", PageController, :home
  end

  scope "/", GoogleAuthRecipeWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/protected", ProtectedController, :show

    live_session :authenticated,
      on_mount: [
        {GoogleAuthRecipeWeb.Auth.UserAuth, :ensure_authenticated},
        {GoogleAuthRecipeWeb.Auth.UserAuth, :mount_current_user}
      ] do
      # live "/some_path", SomeLive.Index
    end
  end

  ## Authentication routes

  scope "/auth", GoogleAuthRecipeWeb.Auth do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/log_in", UserSessionController, :new
  end

  scope "/auth", GoogleAuthRecipeWeb.Auth do
    pipe_through [:browser]

    delete "/log_out", UserSessionController, :delete
    get "/:provider", GoogleController, :request
    get "/:provider/callback", GoogleController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", GoogleAuthRecipeWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:google_auth_recipe, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GoogleAuthRecipeWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
