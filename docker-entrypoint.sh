#!/bin/sh

export AWSACCESSKEYID=${ACCESS_KEY_ID}
export AWSSECRETACCESSKEY=${SECRET_ACCESS_KEY}

if [ -z "$S3_URL" ]
then
    s3fs "$S3_BUCKET" "$MNT_POINT"
else
    s3fs "$S3_BUCKET" "$MNT_POINT" -o url="$S3_URL" -o use_path_request_style
fi

cd /data

youtube-dl $@