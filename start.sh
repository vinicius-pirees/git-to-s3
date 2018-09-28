#!/bin/bash

set -e

: ${ACCESS_KEY:?"ACCESS_KEY env variable is required"}
: ${SECRET_KEY:?"SECRET_KEY env variable is required"}
: ${S3_PATH:?"S3_PATH env variable is required"}

export DATA_PATH=${DATA_PATH:-/data/}

echo "access_key=$ACCESS_KEY" >> /root/.s3cfg
echo "secret_key=$SECRET_KEY" >> /root/.s3cfg

echo "Parameter is $1"

if [[ "$1" == 'git-ssh' ]]; then
    echo "Backing up git repos..."
    : ${GIT_REPO:?"GIT_REPO env variable is required"}
    rm -rf $DATA_PATH
    git clone $GIT_REPO $DATA_PATH
    rm -rf $DATA_PATH/.git
    exec /sync.sh

elif [[ "$1" == 'git-http' ]]; then
    echo "Backing up git repos..."
    : ${GIT_REPO:?"GIT_REPO env variable is required"}
    : ${GIT_USER:?"GIT_USER env variable is required"}
    : ${GIT_PASSWORD:?"GIT_PASSWORD env variable is required"}

    credentials=https://$GIT_USER:$GIT_PASSWORD@
    GIT_URL=$(echo ${GIT_REPO//https:\/\//$credentials})

    rm -rf $DATA_PATH
    git clone $GIT_URL $DATA_PATH
    rm -rf $DATA_PATH/.git
    exec /sync.sh

else
    echo "Not a valid argument!"
fi
