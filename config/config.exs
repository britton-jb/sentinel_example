# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sentinel_example,
  ecto_repos: [SentinelExample.Repo]

# Configures the endpoint
config :sentinel_example, SentinelExample.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aNFSebyymWf897GTjjzETL8OqpsYtPZ/EdsRRi+5Q+hIwIUGanIN/p/1bRC7kUQ+",
  render_errors: [view: SentinelExample.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SentinelExample.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Sentinel Example",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "guardian_sekret",
  serializer: Sentinel.GuardianSerializer,
  hooks: GuardianDb # optional if using guardiandb

config :guardian_db, GuardianDb,
  repo: SentinelExample.Repo

config :sentinel,
  app_name: "Test App",
  user_model: SentinelExample.User, # should be your generated model
  send_address: "test@example.com",
  crypto_provider: Comeonin.Bcrypt,
  repo: SentinelExample.Repo,
  ecto_repos: [Sentinel.Repo],
  auth_handler: Sentinel.AuthHandler,
  layout_view: SentinelExample.LayoutView, # your layout
  layout: :app,
  user_view: Sentinel.UserView,
  error_view: Sentinel.ErrorView,
  router: SentinelExample.Router, # your router
  endpoint: SentinelExample.Endpoint, # your endpoint
  invitable: true,
  invitation_registration_url: "http://localhost:4000", # for api usage only
  confirmable: :optional,
  confirmable_redirect_url: "http://localhost:4000", # for api usage only
  password_reset_url: "http://localhost:4000", # for api usage only
  send_emails: true

config :ueberauth, Ueberauth,
  providers: [
    identity: {
      Ueberauth.Strategy.Identity,
      [
        param_nesting: "user",
        callback_methods: ["POST"]
      ]
    },
    github: { Ueberauth.Strategy.Github, [] },
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :sentinel, Sentinel.Mailer,
  adapter: Bamboo.TestAdapter

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
