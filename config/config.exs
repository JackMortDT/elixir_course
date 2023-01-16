# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :ecommerce_course,
  ecto_repos: [EcommerceCourse.Repo]

# Configures the endpoint
config :ecommerce_course, EcommerceCourseWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: EcommerceCourseWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EcommerceCourse.PubSub,
  live_view: [signing_salt: "qLi3Qijv"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :ecommerce_course, EcommerceCourse.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ecommerce_course, EcommerceCourse.Guardian,
  issuer: "ecommerce_course",
  secret_key: "kEkHu5w3SCNN8c1BXAHNxx0lpCpBQyyWl08Yl1LMPwEyWArVWdExbBaUSk1HNiUo"

config :ecommerce_course, EcommerceCourse.AuthAccessPipeline,
  module: EcommerceCourse.Guardian,
  error_handler: EcommerceCourse.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# config :web_app, WebApp.PromEx,
#   grafana: [
#     host: "http://localhost:3000",
#     username: "<YOUR_USERNAME>",  # Or authenticate via Basic Auth
#     password: "<YOUR_PASSWORD>"
#     auth_token: "<YOUR_AUTH_TOKEN_HERE>", # Or authenticate via API Token
#     upload_dashboards_on_start: true # This is an optional setting and will default to `true`
#   ]

config :ecommerce_course, EcommerceCourse.PromEx,
  manual_metrics_start_delay: :no_delay,
  drop_metrics_groups: [],
  grafana: [
    host: "http://localhost:3000",
    # Or authenticate via Basic Auth
    username: "admin",
    password: "admin",
    # Or authenticate via API Token
    auth_token:
      "eyJrIjoidTJhUUhMVTd6eVUwSkJaODY3UEZvWHpoemJRNlRrdVYiLCJuIjoiUHJvbUV4IiwiaWQiOjF9",
    # This is an optional setting and will default to `true`
    upload_dashboards_on_start: true,
    annotate_app_lifecycle: true,
    folder_name: "Todo App Dashboards"
  ]

import_config "#{config_env()}.exs"
