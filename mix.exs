defmodule Jameswebb.MixProject do
  use Mix.Project

  def project do
    [
      app: :jameswebb,
      version: "0.1.0",
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Jameswebb.Application, []}
    ]
  end

  defp deps do
    [
      {:bandit, "~> 1.6"},
      {:plug, "~> 1.16"},
      {:yaml_elixir, "~> 2.11"},
      {:nebulex, "~> 2.6"},
      {:shards, "~> 1.1"}
    ]
  end
end
