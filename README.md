# S3BucketSizeExporter

Prometheus exporter for S3 bucket sizes. Normally you'd have CloudWatch or some
admin API. This is for a contrived use case where only ListBuckets and
ListObjectsV2 are available.

## Docker

```
docker build -t s3-bucket-size-exporter .
docker run -p 4000:4000 \
  -e "AWS_KEY_ID=xxxx" \
  -e "AWS_SECRET_KEY=xxxx" \
  -e "AWS_REGION=garage" \
  -e "AWS_ENDPOINT_HOST=s3.example.com" \
  s3-bucket-size-exporter
```

## docker-compose

```
version: "3"

services:
  s3-bucket-size-exporter:
    image: iank1/s3-bucket-size-exporter:v0.1.0
    restart: unless-stopped
    ports:
      - "127.0.0.1:4000:4000"
    environment:
      AWS_KEY_ID=xxxx
      AWS_SECRET_KEY=xxxx
      AWS_REGION=garage
      AWS_ENDPOINT_HOST=s3.example.com
```
