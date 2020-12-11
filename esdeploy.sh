docker network create elasticstack
docker run -it -d --network elasticstack -p 9200:9200 -p 5601:5601 --hostname es01 --name es01 --privileged centos:centos7 /sbin/init
docker run -it -d --network elasticstack -p 9201:9200 -p 5602:5601 --hostname es02 --name es02 --privileged centos:centos7 /sbin/init
docker run -it -d --network elasticstack -p 9202:9200 -p 5603:5601 --hostname es03 --name es03 --privileged centos:centos7 /sbin/init

## each command may be exec'ed on each terminal
docker cp essetup.sh es01:/tmp/essetup.sh
docker exec -it es01 /bin/bash /tmp/essetup.sh

docker cp essetup.sh es02:/tmp/essetup.sh
docker exec -it es02 /bin/bash /tmp/essetup.sh

docker cp essetup.sh es03:/tmp/essetup.sh
docker exec -it es03 /bin/bash /tmp/essetup.sh

