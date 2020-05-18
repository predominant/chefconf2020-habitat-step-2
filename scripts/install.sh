#!/bin/sh

curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash
hab license accept
hab pkg install core/cacerts
hab pkg install core/hab-sup

SSL_CERT_FILE="$(hab pkg path core/cacerts)/ssl/cert.pem"

cat <<EOT > /etc/systemd/system/hab-sup.service
[Unit]
Description=Habitat Supervisor

[Service]
ExecStartPre=/bin/bash -c "/bin/systemctl set-environment SSL_CERT_FILE=${SSL_CERT_FILE}"
ExecStart=/bin/hab sup run --peer-watch-file /hab/BASTION-PEERS
ExecStop=/bin/hab sup term
KillMode=process
LimitNOFILE=65535

[Install]
WantedBy=default.target
EOT
