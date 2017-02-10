#!/bin/bash
# filename: docker-entrypoint.sh
set -euxo pipefail

service ssh start
cd /root/PyBitmessage 
git pull

exec "$@"
