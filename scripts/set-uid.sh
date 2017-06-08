#!/bin/bash

USERID=$(id -u)
USERGID=$(id -g)

if [[ "$USERID" == "1000" ]]; then
    echo "Setting UserID skipped (already 1000)"
    exit 0
fi

CPATH=$(pwd)
DIRNAME="$(dirname $0)/.."
cd "$DIRNAME"

cache=$(cat docker-compose.yml | grep '/home/crow/cache' | sed 's/.*-[[:space:]]*\([^:]*\):\/home\/crow\/cache/\1/')
DST="$DIRNAME/$cache"

if [[ ! -d "$DST" ]]; then
    echo "Unable to find directory $DST"
    exit 1
fi

echo "$USERID:$USERGID" > $DST/userid.txt