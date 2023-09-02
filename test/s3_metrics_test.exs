defmodule S3MetricsTest do
  use ExUnit.Case
  doctest S3Metrics

  test "create_client returns an AWS client" do
    assert %AWS.Client{} = S3Metrics.create_client("1234", "abcd", "test", "example.com")
  end

  test "total_object_size returns total size" do
    objects = [
      %{
        "ETag" => "\"400e7b734d75295deee845ec9908c574\"",
        "Key" => "028ebf3a-774e-ab32-aff3-9482a298cf83.png",
        "LastModified" => "2023-09-01T21:06:45.812Z",
        "Size" => "290816",
        "StorageClass" => "STANDARD"
      },
      %{
        "ETag" => "\"ae7f78f1e84b348b89367bbb93761ec0-1\"",
        "Key" => "0492c319-4357-8930-4395-43892abc4980.png",
        "LastModified" => "2023-09-01T15:24:54.344Z",
        "Size" => "299215",
        "StorageClass" => "STANDARD"
      },
      %{
        "ETag" => "\"4af7995ef4d927f078c198a126222c14-1\"",
        "Key" => "043589c3-cd42-8398-b435-4398cb4ef120.png",
        "LastModified" => "2023-09-01T15:02:51.585Z",
        "Size" => "294360",
        "StorageClass" => "STANDARD"
      }
    ]
    assert 884391 = S3Metrics.total_object_size(objects)
  end

  test "format_metrics formats bucket sizes into Prometheus metrics" do
    bucket_sizes = %{
      "bucket1" => 1000,
      "bucket2" => 2000
    }

    expected_output = [
      "# HELP s3_bucket_size_bytes The size of an S3 bucket in bytes.",
      "# TYPE s3_bucket_size_bytes gauge",
      "s3_bucket_size_bytes{bucket=\"bucket1\"} 1000",
      "s3_bucket_size_bytes{bucket=\"bucket2\"} 2000"
    ]

    assert S3Metrics.format_metrics(bucket_sizes) == expected_output
  end
end
