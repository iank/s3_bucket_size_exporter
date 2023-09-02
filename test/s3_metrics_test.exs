defmodule S3MetricsTest do
  use ExUnit.Case
  doctest S3Metrics

  test "greets the world" do
    assert S3Metrics.get_metrics() == "Testing: 1234"
  end
end
