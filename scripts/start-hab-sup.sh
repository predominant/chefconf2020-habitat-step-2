#!/bin/sh

systemctl daemon-reload
systemctl start hab-sup
systemctl enable hab-sup

until hab svc status > /dev/null 2>&1; do
  sleep 1
done
