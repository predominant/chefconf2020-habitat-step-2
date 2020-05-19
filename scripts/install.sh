#!/bin/sh

curl https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh | bash
hab license accept
hab pkg install core/cacerts
hab pkg install core/hab-sup

useradd --system --no-create-home hab
groupadd --system hab

SSL_CERT_FILE="$(hab pkg path core/cacerts)/ssl/cert.pem"
IPADDR=$(ip addr | grep "inet 192" | awk '{print $2}' | awk -F'/' '{print $1}')

cat <<EOT > /etc/systemd/system/hab-sup.service
[Unit]
Description=Habitat Supervisor

[Service]
ExecStartPre=/bin/bash -c "/bin/systemctl set-environment SSL_CERT_FILE=${SSL_CERT_FILE}"
ExecStart=/bin/hab sup run --peer-watch-file /hab/BASTION-PEERS --sys-ip-address ${IPADDR}
ExecStop=/bin/hab sup term
KillMode=process
LimitNOFILE=65535

[Install]
WantedBy=default.target
EOT
