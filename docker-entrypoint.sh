#!/bin/bash

TARGET="$1"
shift

PKI_DIR="/pki"
PKI_DB_DIR="$PKI_DIR/db"

#if $PKI_DB_DIR is empty, bootstrap $PKI_DB_DIR
if ! [ "$(ls -A $PKI_DB_DIR)" ]; then
  echo "NOTE: You can disregard the ls error output above."
  echo "NOTE: No existing CA DB directory detected. Bootstrapping."

  #load in vars file from volume if exists
  if [ -e $PKI_DIR/vars ]; then
    cp $PKI_DIR/vars $PKI_DB_DIR/vars
    rm $PKI_DIR/vars
  fi

  make-cadir $PKI_DB_DIR

  cd $PKI_DB_DIR
  source $PKI_DB_DIR/vars
  $PKI_DB_DIR/clean-all
fi

#bootstrap environment
PATH=$PATH:$PKI_DB_DIR
cd $PKI_DB_DIR

source $PKI_DB_DIR/vars

"$TARGET" "$@"
