#!/bin/bash

declare -gr DevContainerDir="$(cd "$(dirname "$0")"; pwd)"
declare -gr RootDir="$(dirname "$DevContainerDir")"

post_create() {
  echo "post_create"
  pushd "$RootDir"
  sudo gem update --system 3.5.17
  gem install bundler
  bundle install
  popd
}

post_start() {
  echo "post_start"
}

post_attach() {
  echo "post_attach"
}

setup() {
  local -r action="$1"

  case "$action" in
    'CREATE')
      post_create
      ;;
    'START')
      post_start
      ;;
    'ATTACH')
      post_attach
      ;;
  esac
}

setup "$@"
