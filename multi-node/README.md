# Deploy Cyb3rhq Docker in multi node configuration

This deployment is defined in the `docker-compose.yml` file with two Cyb3rhq manager containers, three Cyb3rhq indexer containers, and one Cyb3rhq dashboard container. It can be deployed by following these steps: 

1) Increase max_map_count on your host (Linux). This command must be run with root permissions:
```
$ sysctl -w vm.max_map_count=262144
```
2) Run the certificate creation script:
```
$ docker-compose -f generate-certs.yml run --rm generator
```
3) Start the environment with docker-compose:

- In the foregroud:
```
$ docker-compose up
```

- In the background:
```
$ docker-compose up -d
```


The environment takes about 1 minute to get up (depending on your Docker host) for the first time since Cyb3rhq Indexer must be started for the first time and the indexes and index patterns must be generated.
