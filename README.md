# S3BucketSizeExporter

Prometheus exporter for S3 bucket sizes. Normally you'd have CloudWatch or some
admin API. This is for a contrived use case where only ListBuckets and
ListObjectsV2 are available.

## Docker

```
docker build -t s3_bucket_size_exporter .
docker run -p 4000:4000 \
  -e "AWS_KEY_ID=xxxx" \
  -e "AWS_SECRET_KEY=xxxx" \
  -e "AWS_REGION=garage" \
  -e "AWS_ENDPOINT_HOST=s3.example.com" \
  s3_bucket_size_exporter
```

## docker-compose

```
version: "3"

services:
  s3_bucket_size_exporter:
    image: iank1/s3_bucket_size_exporter:v0.1.1
    restart: unless-stopped
    ports:
      - "127.0.0.1:4000:4000"
    environment:
      - AWS_KEY_ID=xxxx
      - AWS_SECRET_KEY=xxxx
      - AWS_REGION=garage
      - AWS_ENDPOINT_HOST=s3.example.com
```

## Prometheus config

You probably don't want this to run too often.

In the configuration snippet below I've put this behind a reverse proxy under the path "/s3metrics".

```
scrape_configs:
- job_name: 's3-metrics'
  scheme: https
  scrape_interval: 30m
  scrape_timeout: 20s
  metrics_path: /s3metrics
  static_configs:
  - targets: ['myhost.example.com']
    labels:
      instance: myhost
```
