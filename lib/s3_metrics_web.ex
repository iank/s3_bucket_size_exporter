defmodule S3MetricsWeb do
  use Plug.Builder

  def start_link(opts) do
    {:ok, _} = Plug.Cowboy.http(S3MetricsWeb, opts, port: 4000)
  end

  def call(conn, [key_id: key_id, secret_key: secret_key, region: region, endpoint: endpoint]) do
    client = S3Metrics.create_client(key_id, secret_key, region, endpoint)

    metrics = S3Metrics.get_metrics(client)
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, Enum.join(metrics, "\n"))
  end
end
