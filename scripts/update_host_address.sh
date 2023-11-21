#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

host_address="$($CURRENT_DIR/host_address.sh)"

do_interpolation() {
  local string="$1"
  local host_addr=$host_address
  if [ -z "$host_address" ]
  then
    host_addr="Offline"
  fi

  local interpolated="$(echo $1 | sed "s/\x07.*\x07/\x07$host_addr\x07/g")"

  echo "$interpolated"
}

update_tmux_option() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
}
main
