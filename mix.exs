defmodule Gogetssl.MixProject do
  use Mix.Project

  def project do
    [
      app: :gogetssl,
      version: "0.1.0",
      elixir: "~> 1.16",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]

  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    GOGETSSL API in Elixir language
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Przemyslaw Pajak"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/fearless-spider/gogetssl"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:poison, "~> 5.0"},
      {:ex_doc, "~> 0.31.1", only: :dev, runtime: false}
    ]
  end
end
