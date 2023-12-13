defmodule ApexECS.MixProject do
  use Mix.Project

  @github_url "https://github.com/Teifion/apex_ecs"
  @version "0.0.1"

  def project do
    [
      app: :apex_ecs,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: "MIT Licensed ECS engine for Elixir",
      package: package(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {ApexECS, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Teifion Jordan"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "#{@github_url}/blob/master/CHANGELOG.md",
        "GitHub" => @github_url
      }
    ]
  end
end
