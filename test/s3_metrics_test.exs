defmodule S3MetricsTest do
  use ExUnit.Case
  doctest S3Metrics

  test "create_client returns an AWS client" do
    assert %AWS.Client{} = S3Metrics.create_client("1234", "abcd", "test", "example.com")
  end
end
