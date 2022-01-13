#!/bin/sh

s3fs $S3_BUCKET_NAME:/test-1 $S3_MOUNT_DIRECTORY -o passwd_file=/root/.passwd-s3fs
uvicorn main:app --host 0.0.0.0