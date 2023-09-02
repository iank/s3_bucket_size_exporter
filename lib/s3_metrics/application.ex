defmodule S3Metrics.Application do
  use Application

  def start(_type, _args) do
    # This will start our web server when the application starts
    S3MetricsWeb.start_link([
      key_id: System.get_env("AWS_KEY_ID"),
      secret_key: System.get_env("AWS_SECRET_KEY"),
      region: System.get_env("AWS_REGION"),
      endpoint: System.get_env("AWS_ENDPOINT_HOST"),
    ])
  end
end
