#!/bin/sh

s3fs $S3_BUCKET_NAME:/$S3_ANNOTATION_DIRECTORY $LOCAL_MOUNT_DIRECTORY -o nonempty -o iam_role=$AWS_IAM_ROLE -o dbglevel=info -o curldbg -o endpoint=$AWS_REGION
# If the role does not work by default, use this option: -o passwd_file=/root/.passwd-s3fs

uvicorn main:app --host 0.0.0.0