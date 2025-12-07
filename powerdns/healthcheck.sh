#!/bin/sh

# check powerdns
PDNS_STATUS=$(pdns_control ping)
echo "${PDNS_STATUS}"
if [ "${PDNS_STATUS}" != "PONG" ]; then
  exit 1
fi

exit 0
