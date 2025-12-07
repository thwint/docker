#!/bin/bash
function _log() {
  severity="${1}"
  shift
  printf "%s %b: %s\n" "$(date '+%F %T.%N' | cut -b1-23)" "${severity}" "$*"
}

function log_info() {
  _log "INFO" "${@}"
}

function log_error() {
  _log "ERROR" "${@}" >&2
  exit 1
}

function get_process_count() {
  PROC_COUNT=$(pgrep -l "${1}" | grep -vc grep)
}

get_process_count "chromium/chrome"
if [ "${PROC_COUNT}" -ge 8 ]; then
  log_info "chromium is running"
else
  log_error "Only ${PROC_COUNT} chromium processes running. Exiting!"
fi

get_process_count "Xvfb"
if [ "${PROC_COUNT}" -eq 1 ]; then
  log_info "Xvfb is running"
else
  log_error "No Xvfb process is running. Exiting!"
fi

get_process_count "x11vnc"
if [ "${PROC_COUNT}" -ge 1 ]; then
  log_info "x11vnc is running"
else
  log_error "No x11vnc process is running. Exiting!"
fi

exit 0
