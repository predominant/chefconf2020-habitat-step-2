#!/bin/sh

BASTION_FILE="/hab/BASTION-PEERS"
rm -f "${BASTION_FILE}"
echo "192.168.33.10" > "${BASTION_FILE}"
