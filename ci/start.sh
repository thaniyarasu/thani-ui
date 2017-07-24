#!/bin/bash
set -e -x

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pushd $DIR/..
  cp -r ./../cache/.pub .
  cp -r ./../cache/.packages .
  pub serve --hostname=0.0.0.0 --port=8080 
popd


#&& tail -f /dev/null
