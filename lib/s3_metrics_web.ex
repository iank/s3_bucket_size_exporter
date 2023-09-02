defmodule S3MetricsWeb do
  use Plug.Builder

  def start_link(_opts) do
    {:ok, _} = Plug.Cowboy.http(S3MetricsWeb, [], port: 4000)
  end

  def call(conn, _opts) do
    metrics = S3Metrics.get_metrics()
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, metrics)
  end
end
