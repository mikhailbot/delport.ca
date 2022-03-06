defmodule DelportCaWeb.Router do
  use DelportCaWeb, :router

  import DelportCaWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DelportCaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DelportCaWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/writing", PostController, :index
    get "/:year/:slug", PostController, :show
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DelportCaWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", DelportCaWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/admin/users/log_in", UserSessionController, :new
    post "/admin/users/log_in", UserSessionController, :create
    get "/admin/users/reset_password", UserResetPasswordController, :new
    post "/admin/users/reset_password", UserResetPasswordController, :create
    get "/admin/users/reset_password/:token", UserResetPasswordController, :edit
    put "/admin/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", DelportCaWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/admin/users/settings", UserSettingsController, :edit
    put "/admin/users/settings", UserSettingsController, :update
    get "/admin/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", DelportCaWeb do
    pipe_through [:browser]

    delete "/admin/users/log_out", UserSessionController, :delete
    get "/admin/users/confirm", UserConfirmationController, :new
    post "/admin/users/confirm", UserConfirmationController, :create
    get "/admin/users/confirm/:token", UserConfirmationController, :edit
    post "/admin/users/confirm/:token", UserConfirmationController, :update
  end
end
