#!/bin/bash

CPATH=$(pwd)
DIRNAME="$(dirname $0)/.."
cd "$DIRNAME"

cache=$(cat docker-compose.yml | grep '/home/crow/cache' | sed 's/.*-[[:space:]]*\([^:]*\):\/home\/crow\/cache/\1/')
DST="$DIRNAME/$cache"

if [[ ! -d "$DST" ]]; then
    echo "Unable to find directory $DST"
    exit 1
fi

if [[ ! -f ~/.ssh/crow ]]; then
    ssh-keygen -f ~/.ssh/crow -N '' -t rsa -b 2048
fi
cp ~/.ssh/crow.pub "$DST/authorized_keys"
