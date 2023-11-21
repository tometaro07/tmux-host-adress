#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

host_address="$($CURRENT_DIR/scripts/host_address.sh)"
host_address_interpolation_string="\#{host_address}"
host_address_refresh_cmd_key="$(get_tmux_option "@host_address_refresh_key" "A")"

do_interpolation() {
  local string="$1"
  local host_addr=$host_address
  if [ -z "$host_addr" ]
  then
    host_addr="Offline"
  fi

  local interpolated="$(echo $1 | sed "s/$host_address_interpolation_string/\x07$host_addr\x07/g")"

  echo "$interpolated"
}

update_tmux_option() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

main() {
  tmux bind-key "host_address_refresh_cmd_key" run-shell -b "$CURRENT_DIR/scripts/update_host_address.sh"
  update_tmux_option "status-right"
}
main
