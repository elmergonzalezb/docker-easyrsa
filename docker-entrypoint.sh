#!/bin/bash

DIR='/pki'

#if $DIR is empty, call init
if [ "$(ls -A $DIR)" ]; then
  /scripts/init.sh
fi

exec /scripts/run.sh "$@"
