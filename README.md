# S3BucketSizeExporter

Prometheus exporter for S3 bucket sizes. Normally you'd have CloudWatch or some
admin API. This is for a contrived use case where only ListBuckets and
ListObjectsV2 are available.
