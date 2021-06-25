#!/usr/bin/env bash

if [ ! -f /usr/bin/git ]; then 
  apt update  -qq
  apt install -qq -y curl make golang-go git less vim
  useradd -s /bin/bash -d /code -u 10000  code 
fi

balena-idle
