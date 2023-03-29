defmodule Openai.MixProject do
  use Mix.Project

  def project do
    [
      app: :openaimt,
      version: "0.3.1",
      elixir: "~> 1.11",
      description: description(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "openai.ex-mt",
      source_url: "https://github.com/Miserlou/openai.ex"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {OpenAI, []},
      applications: [:httpoison, :json, :logger],
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    community-maintained OpenAI API Wrapper written in Elixir. Modded for mt.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      exclude_patterns: ["./config/*"],
      links: %{
        "GitHub" => "https://github.com/Miserlou/openai.ex"
      },
      maintainers: [
        "Miserlou"
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:json, "~> 1.4"},
      {:httpoison, "~> 1.8"},
      {:mock, "~> 0.3.6"},
      {:mix_test_watch, "~> 1.0"},
      {:ex_doc, ">= 0.19.2", only: :dev}
    ]
  end
end
