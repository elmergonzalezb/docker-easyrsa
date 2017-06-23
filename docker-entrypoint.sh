#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "You did not specify a command." >&2
  exit 1
fi

TARGET="$1"
shift


PKI_DIR="/pki"
PKI_DB_DIR="$PKI_DIR/db"

#if $PKI_DB_DIR is empty, bootstrap $PKI_DB_DIR
if [ ! -d "$PKI_DB_DIR" ]; then
  #load in vars file from volume if exists
  if [ -e $PKI_DIR/vars ]; then
    cp $PKI_DIR/vars $PKI_DB_DIR/vars
    rm $PKI_DIR/vars
  fi

  make-cadir $PKI_DB_DIR

  cd $PKI_DB_DIR
  source $PKI_DB_DIR/vars &> /dev/null
  $PKI_DB_DIR/clean-all
fi

#bootstrap environment
PATH=$PATH:$PKI_DB_DIR
cd $PKI_DB_DIR

source $PKI_DB_DIR/vars &> /dev/null

"$TARGET" "$@"
