# esdocker
elasticsearch cluster deploy on docker

## what does this do?
In WSL2 environment, you can deploy 3 docker containers which will run a custom script to install Elasticsearch and Kibana.

## for Docker automation (single)
```
# cd essetup-single
# docker build -t essingle .
# docker run -it -d --network elasticstack -p 9200:9200 -p 5601:5601 --hostname es01 --name es01 --privileged essingle /sbin/init
```

## for Docker automation (cluster)
```
# cd essetup-cluster
# docker build -t escluster .
# docker run -it -d --network elasticstack -p 9200:9200 -p 5601:5601 --hostname es01 --name es01 --privileged escluster /sbin/init
# docker run -it -d --network elasticstack -p 9201:9200 -p 5602:5601 --hostname es02 --name es02 --privileged escluster /sbin/init
# docker run -it -d --network elasticstack -p 9202:9200 -p 5603:5601 --hostname es03 --name es03 --privileged escluster /sbin/init
```

## for Docker automation (esmon)
```
# cd esmon
# docker build -t esmon .
# docker run -it -d --network elasticstack -p 9209:9200 -p 5609:5601 --hostname mon01 --name mon01 --privileged esmon /sbin/init
```


## reference
https://qiita.com/tetsuyasodo/items/8d37a25809f0e72a570f
