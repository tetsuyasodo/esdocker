1台構成のESで、自ホスト(vm01)をNFSサーバにしてrepoを設定
```
# cat <<'EOF' >>/etc/elasticsearch/elastisearch.yml
path.repo: ["/mount/repository"]
EOF
```

NFSサーバ　※イメージ構成済
```
$ sudo yum install -y nfs-utils
$ sudo mkdir -p /var/elasticsearch/repository
$ sudo chown -R elasticsearch:elasticsearch /var/elasticsearch/repository
$ sudo systemctl enable nfs-server
$ sudo systemctl start nfs-server
$ sudo systemctl status nfs-server
```

exports設定　※イメージ構成済
```
# cat <<'EOF' >/etc/exports
/var/elasticsearch/repository *(rw,async,no_root_squash)
EOF
```

NFSサーバ再起動とfirewall穴あけ　※イメージ構成済
```
$ sudo systemctl reload nfs-server
$ sudo exportfs -av
$ sudo firewall-cmd --permanent --zone=public --add-service=nfs
$ sudo firewall-cmd --reload
```

NFSクライアント（自ホスト兼任）
```
$ sudo yum install -y nfs-utils
$ sudo mkdir -p /mount/repository
$ sudo chown -R elasticsearch:elasticsearch /mount/repository
$ sudo systemctl enable rpcbind
$ sudo systemctl start rpcbind
$ sudo mount -t nfs vm01:/var/elasticsearch/repository/ /mount/repository/
$ sudo systemctl restart elasticsearch
```

dev toolsからリポジトリ設定、インデックス作成、ドキュメント作成、スナップショット取得、searchable snapshot作成、検索テスト
```
PUT _snapshot/repository1
{
  "type": "fs",
  "settings": {
    "location": "/mount/repository/repository1",
    "compress": true
  }
}
POST my_index/_doc
{
  "name": "john"
}
POST my_index/_doc
{
  "name": "taro"
}

PUT _snapshot/repository1/snapshot1?wait_for_completion=true
{
  "indices": "my_index"
}
```
