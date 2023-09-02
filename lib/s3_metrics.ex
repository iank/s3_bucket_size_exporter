defmodule S3Metrics do
  def create_client(key_id, secret_key, region, endpoint) do
    AWS.Client.create(key_id, secret_key, region)
    |> AWS.Client.put_endpoint(endpoint)
  end

  def list_buckets(client) do
    {:ok, %{"ListAllMyBucketsResult" => %{ "Buckets" => %{ "Bucket" => buckets }}}, _} =
      AWS.S3.list_buckets(client)
    Enum.map(buckets, fn bucket -> bucket["Name"] end)
  end

  def get_metrics(client) do
    buckets = list_buckets(client)
    buckets[0]
  end
end
