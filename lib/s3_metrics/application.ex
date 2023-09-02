defmodule S3Metrics.Application do
  use Application

  def start(_type, _args) do
    # This will start our web server when the application starts
    S3MetricsWeb.start_link([])
  end
end
