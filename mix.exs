defmodule Ddd.Mixfile do
  use Mix.Project

  def project do
    [ app: :ddd,
      version: "0.0.1",
      elixir: "~> 1.0.0-rc1",
      elixirc_paths: ["lib", "web"],
      deps: deps,
      external_actions: external_actions(Mix.env)
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Ddd, [] },
      applications: [:phoenix, :cowboy, :logger]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:phoenix, "0.4.1"},
      {:cowboy, "~> 1.0.0"},
      {:mailgun, "~> 0.0.1"},
      {:httpoison, "~> 0.4"}
    ]
  end

  defp external_actions(:test), do: false
  defp external_actions(_), do: true

end
