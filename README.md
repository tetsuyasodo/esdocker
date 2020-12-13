# esdocker
elasticsearch cluster deploy on docker

## what does this do?
In WSL2 environment, you can deploy 3 docker containers which will run a custom script to install Elasticsearch and Kibana.

## for Docker automation
```
# cd essetup-single
# docker build -t essingle .
# docker run -it -d --network elasticstack -p 9200:9200 -p 5601:5601 --hostname es01 --name es01 --privileged essingle /sbin/init
```
