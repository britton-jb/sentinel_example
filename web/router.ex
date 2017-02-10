defmodule SentinelExample.Router do
  use SentinelExample.Web, :router
  require Sentinel

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :sentinel_ueberauth do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through :sentinel_ueberauth
    Sentinel.mount_ueberauth
  end

  scope "/" do
    pipe_through :browser
    Sentinel.mount_html
  end

  scope "/api", as: :api do
    pipe_through :api
    Sentinel.mount_api
  end

  scope "/", SentinelExample do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", SentinelExample do
  #   pipe_through :api
  # end
end
