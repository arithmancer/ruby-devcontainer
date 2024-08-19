#!/bin/bash

declare -gr DevContainerDir="$(cd "$(dirname "$0")"; pwd)"
declare -gr RootDir="$(dirname "$DevContainerDir")"

setup_ruby() {
  echo 'setup_ruby'
  pushd "$RootDir"
  sudo gem update --system 3.5.17
  gem install bundler
  bundle install
  popd
}

install_aws_cli() {
  echo 'install_aws_cli'
  if [ "$(uname -m)" = 'x86_64' ]; then
    local -r url='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
  else
    local -r url='https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip'
  fi
  local -r filename='awscliv2.zip'

  pushd '/tmp'
  curl "$url" -o "$filename"
  unzip "$filename"
  rm "$filename"
  sudo ./aws/install
  rm -rf 'aws'
  popd
}

post_create() {
  echo 'post_create'
  setup_ruby
  install_aws_cli
}

post_start() {
  echo 'post_start'
}

post_attach() {
  echo 'post_attach'
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
