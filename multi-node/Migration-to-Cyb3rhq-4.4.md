# Opendistro data migration to Cyb3rhq indexer on docker.
This procedure explains how to migrate Opendistro data from Opendistro to Cyb3rhq indexer in docker production deployments.
The example is migrating from v4.2 to v4.4.

## Procedure
Assuming that you have a v4.2 production deployment, perform the following steps.

**1. Stop 4.2 environment**
`docker-compose -f production-cluster.yml stop`

**2. List elasticsearch volumes**
`docker volume ls --filter name='cyb3rhq-docker_elastic-data'`

**3. Inspect elasticsearch volume**
`docker volume inspect cyb3rhq-docker_elastic-data-1`

**4. Spin down the 4.2 environment.**
`docker-compose -f production-cluster.yml down`

**Steps 5 and 6 can be done with the volume-migrator.sh script, specifying Docker compose version and project name as parameters.**

Ex: $ multi-node/volume-migrator.sh 1.25.0 multi-node

**5. Run the volume create command:** create new indexer and Cyb3rhq manager volumes using the `com.docker.compose.version` label value from the previous command.

```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=cyb3rhq-indexer-data-1 \
           multi-node_cyb3rhq-indexer-data-1
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=cyb3rhq-indexer-data-2 \
           multi-node_cyb3rhq-indexer-data-2
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=cyb3rhq-indexer-data-3 \
           multi-node_cyb3rhq-indexer-data-3
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master_cyb3rhq_api_configuration \
           multi-node_master_cyb3rhq_api_configuration
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master_cyb3rhq_etc \
           multi-node_docker_cyb3rhq_etc
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-cyb3rhq-logs \
           multi-node_master-cyb3rhq-logs
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-cyb3rhq-queue \
           multi-node_master-cyb3rhq-queue
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-cyb3rhq-var-multigroups \
           multi-node_master-cyb3rhq-var-multigroups
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-cyb3rhq-integrations \
           multi-node_master-cyb3rhq-integrations
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-cyb3rhq-active-response \
           multi-node_master-cyb3rhq-active-response
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-cyb3rhq-agentless \
           multi-node_master-cyb3rhq-agentless
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-cyb3rhq-wodles \
           multi-node_master-cyb3rhq-wodles
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-filebeat-etc \
           multi-node_master-filebeat-etc
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-filebeat-var \
           multi-node_master-filebeat-var
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker_cyb3rhq_api_configuration \
           multi-node_worker_cyb3rhq_api_configuration
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker_cyb3rhq_etc \
           multi-node_worker-cyb3rhq-etc
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-cyb3rhq-logs \
           multi-node_worker-cyb3rhq-logs
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-cyb3rhq-queue \
           multi-node_worker-cyb3rhq-queue
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-cyb3rhq-var-multigroups \
           multi-node_worker-cyb3rhq-var-multigroups
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-cyb3rhq-integrations \
           multi-node_worker-cyb3rhq-integrations
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-cyb3rhq-active-response \
           multi-node_worker-cyb3rhq-active-response
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-cyb3rhq-agentless \
           multi-node_worker-cyb3rhq-agentless
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-cyb3rhq-wodles \
           multi-node_worker-cyb3rhq-wodles
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-filebeat-etc \
           multi-node_worker-filebeat-etc
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-filebeat-var \
           multi-node_worker-filebeat-var
```
**6. Copy the volume content from elasticsearch to Cyb3rhq indexer volumes and old Cyb3rhq manager content to new volumes.**
```
docker container run --rm -it \
           -v cyb3rhq-docker_elastic-data-1:/from \
           -v multi-node_cyb3rhq-indexer-data-1:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_elastic-data-2:/from \
           -v multi-node_cyb3rhq-indexer-data-2:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_elastic-data-3:/from \
           -v multi-node_cyb3rhq-indexer-data-3:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_ossec-api-configuration:/from \
           -v multi-node_master-cyb3rhq-api-configuration:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_ossec-etc:/from \
           -v multi-node_master-cyb3rhq-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_ossec-logs:/from \
           -v multi-node_master-cyb3rhq-logs:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_ossec-queue:/from \
           -v multi-node_master-cyb3rhq-queue:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_ossec-var-multigroups:/from \
           -v multi-node_master-cyb3rhq-var-multigroups:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_ossec-integrations:/from \
           -v multi-node_master-cyb3rhq-integrations:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_ossec-active-response:/from \
           -v multi-node_master-cyb3rhq-active-response:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_ossec-agentless:/from \
           -v multi-node_master-cyb3rhq-agentless:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_ossec-wodles:/from \
           -v multi-node_master-cyb3rhq-wodles:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_filebeat-etc:/from \
           -v multi-node_master-filebeat-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_filebeat-var:/from \
           -v multi-node_master-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-api-configuration:/from \
           -v multi-node_worker-cyb3rhq-api-configuration:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-etc:/from \
           -v multi-node_worker-cyb3rhq-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-logs:/from \
           -v multi-node_worker-cyb3rhq-logs:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-queue:/from \
           -v multi-node_worker-cyb3rhq-queue:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-var-multigroups:/from \
           -v multi-node_worker-cyb3rhq-var-multigroups:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-integrations:/from \
           -v multi-node_worker-cyb3rhq-integrations:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-active-response:/from \
           -v multi-node_worker-cyb3rhq-active-response:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-agentless:/from \
           -v multi-node_worker-cyb3rhq-agentless:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-wodles:/from \
           -v multi-node_worker-cyb3rhq-wodles:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-filebeat-etc:/from \
           -v multi-node_worker-filebeat-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v cyb3rhq-docker_worker-filebeat-var:/from \
           -v multi-node_worker-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```

**7. Start the 4.4 environment.**
```
git checkout 4.4
cd multi-node
docker-compose -f generate-certs.yml run --rm generator
docker-compose up -d
```

**8. Check the access to Cyb3rhq dashboard**: go to the Cyb3rhq dashboard using the web browser and check the data.
