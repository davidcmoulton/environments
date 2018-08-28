#!/bin/bash
# deploys to a remote VM
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 ENVIRONMENT_NAME"
    exit 1
fi

environment_name="$1"
hostname="${environment_name}.libero.pub"
scp scripts/remote-deploy.sh "$hostname":/tmp/remote-deploy.sh
revision_browser=$(scripts/latest-revision.sh git@github.com:libero/browser)
ssh "$hostname" REVISION_BROWSER="$revision_browser" /tmp/remote-deploy.sh
