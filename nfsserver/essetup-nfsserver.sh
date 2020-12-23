#!/bin/bash

yum install -y nfs-utils
mkdir -p /var/elasticsearch/repository
chown -R elasticsearch:elasticsearch /var/elasticsearch/repository
systemctl enable nfs-server
systemctl start nfs-server

cat <<'EOF' >/etc/exports
/var/elasticsearch/repository *(rw,async,no_root_squash)
EOF

systemctl reload nfs-server
exportfs -av
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --reload

