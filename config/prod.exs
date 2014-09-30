use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Ddd.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_ddd_key",
  session_secret: "(%U=210+1N8(_C1^ZZEZD*!3O2LH@V0X5@TOG7^L8)*+%KXK^$9&^@QX^IWQ#ZZ9MNFLZUSN7"

config :logger, :console,
  level: :info,
  metadata: [:request_id]

