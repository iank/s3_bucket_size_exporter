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

  def total_object_size(objects) do
    Enum.reduce(objects, 0, fn object, acc ->
      case object do
        %{"Size" => size} when is_binary(size) ->
          acc + String.to_integer(size)
      end
    end)
  end

  def get_bucket_sizes(client) do
    buckets = list_buckets(client)
    buckets |> Enum.map(fn bucket_name ->
      size = S3Paginator.list_all_objects(client, bucket_name) |> total_object_size
      {bucket_name, size}
    end) |> Enum.into(%{})
  end

  def format_metrics(bucket_sizes) do
    header = [
      "# HELP s3_bucket_size_bytes The size of an S3 bucket in bytes.",
      "# TYPE s3_bucket_size_bytes gauge"
    ]

    metrics = Enum.map(bucket_sizes, fn {bucket_name, size} ->
      "s3_bucket_size_bytes{bucket=\"#{bucket_name}\"} #{size}"
    end)

    header ++ metrics
  end

  def get_metrics(client) do
    get_bucket_sizes(client)
    |> format_metrics()
  end
end
