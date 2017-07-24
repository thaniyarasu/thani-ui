#!/bin/bash
set -e -x

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd $DIR/..
  pub get
  pub build
  rm -rf build/web/packages
popd

