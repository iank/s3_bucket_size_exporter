defmodule S3BucketSizeExporter.MixProject do
  use Mix.Project

  def project do
    [
      app: :s3_bucket_size_exporter,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {S3Metrics.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:aws, "~> 0.13.3"},
      {:hackney, "~> 1.18"},
      {:plug_cowboy, "~> 2.6"},
      {:plug, "~> 1.14"}
    ]
  end
end
