defmodule S3Paginator do
  def list_all_objects(client, bucket_name) do
    list_all_objects(client, bucket_name, nil, [])
  end

  defp list_all_objects(client, bucket_name, continuation_token, acc) do
    case AWS.S3.list_objects_v2(client, bucket_name, continuation_token) do
      {:ok,
       %{"ListBucketResult" => %{"Contents" => objects, "NextContinuationToken" => next_token}},
       _}
      when is_binary(next_token) ->
        list_all_objects(client, bucket_name, next_token, acc ++ objects)

      {:ok, %{"ListBucketResult" => %{"Contents" => objects}}, _} ->
        acc ++ objects

      {:error, _} = error ->
        error
    end
  end
end
