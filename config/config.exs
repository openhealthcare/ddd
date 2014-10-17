# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Ddd.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_ddd_key",
  session_secret: "(%U=210+1N8(_C1^ZZEZD*!3O2LH@V0X5@TOG7^L8)*+%KXK^$9&^@QX^IWQ#ZZ9MNFLZUSN7",
  catch_errors: true,
  debug_errors: false,
  error_controller: Ddd.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ddd, mailgun_domain: "sandbox2f06dae5c6c840b9824a8160a83e0e72.mailgun.org",
             mailgun_key: System.get_env("MAILGUN_KEY")

  
# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"



