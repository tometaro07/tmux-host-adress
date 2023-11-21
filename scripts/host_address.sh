#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_host_address() {
  local host_address=$(hostname -i)
  echo ${host_address}
}

main() {
  print_host_address
}

main
