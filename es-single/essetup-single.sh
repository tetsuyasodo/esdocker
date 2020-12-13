#!/bin/bash

cat <<'EOF' >/etc/yum.repos.d/es.repo
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum install -y elasticsearch kibana

cat <<'EOF' >>/etc/elasticsearch/elasticsearch.yml
cluster.name: cluster01
network.host: 0.0.0.0
discovery.seed_hosts: ["es01"]
cluster.initial_master_nodes:  ["es01"]
EOF

cat <<'EOF' >>/etc/kibana/kibana.yml
server.host: "0.0.0.0"
EOF

systemctl daemon-reload
systemctl start elasticsearch
systemctl start kibana

exec "$@"
