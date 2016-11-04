#!/bin/bash

set -xe

# If user don't provide any command
# start the BIND server
# Run as user "bind"
if [[ "$1" == "" ]]; then
    echo "Starting BIND"
    # exec gosu bind named
    exec named -c /etc/bind/named.conf -g
else
    # Else allow the user to run arbitrarily commands like bash
    exec "$@"
fi
