#!/bin/bash
set -e -x

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd $DIR/..
  cp -r ./../cache/.pub .
  cp -r ./../cache/.packages .
  ls -lart
  pub run test
popd


# DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# pushd $DIR/..
#   docker-compose run --rm ui pub get
#   docker-compose run --rm ui pub run test
# popd

