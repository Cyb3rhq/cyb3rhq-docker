docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=cyb3rhq-indexer-data-1 \
           $2_cyb3rhq-indexer-data-1

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=cyb3rhq-indexer-data-2 \
           $2_cyb3rhq-indexer-data-2

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=cyb3rhq-indexer-data-3 \
           $2_cyb3rhq-indexer-data-3

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master_cyb3rhq_api_configuration \
           $2_master_cyb3rhq_api_configuration

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master_cyb3rhq_etc \
           $2_docker_cyb3rhq_etc

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-cyb3rhq-logs \
           $2_master-cyb3rhq-logs

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-cyb3rhq-queue \
           $2_master-cyb3rhq-queue

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-cyb3rhq-var-multigroups \
           $2_master-cyb3rhq-var-multigroups

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-cyb3rhq-integrations \
           $2_master-cyb3rhq-integrations

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-cyb3rhq-active-response \
           $2_master-cyb3rhq-active-response

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-cyb3rhq-agentless \
           $2_master-cyb3rhq-agentless

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-cyb3rhq-wodles \
           $2_master-cyb3rhq-wodles

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-filebeat-etc \
           $2_master-filebeat-etc

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-filebeat-var \
           $2_master-filebeat-var

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker_cyb3rhq_api_configuration \
           $2_worker_cyb3rhq_api_configuration

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker_cyb3rhq_etc \
           $2_worker-cyb3rhq-etc

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-cyb3rhq-logs \
           $2_worker-cyb3rhq-logs

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-cyb3rhq-queue \
           $2_worker-cyb3rhq-queue

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-cyb3rhq-var-multigroups \
           $2_worker-cyb3rhq-var-multigroups

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-cyb3rhq-integrations \
           $2_worker-cyb3rhq-integrations

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-cyb3rhq-active-response \
           $2_worker-cyb3rhq-active-response

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-cyb3rhq-agentless \
           $2_worker-cyb3rhq-agentless

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-cyb3rhq-wodles \
           $2_worker-cyb3rhq-wodles

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-filebeat-etc \
           $2_worker-filebeat-etc

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-filebeat-var \
           $2_worker-filebeat-var

docker container run --rm -it \
           -v cyb3rhq-docker_worker-filebeat-var:/from \
           -v $2_worker-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_elastic-data-1:/from \
           -v $2_cyb3rhq-indexer-data-1:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_elastic-data-2:/from \
           -v $2_cyb3rhq-indexer-data-2:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_elastic-data-3:/from \
           -v $2_cyb3rhq-indexer-data-3:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_ossec-api-configuration:/from \
           -v $2_master-cyb3rhq-api-configuration:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_ossec-etc:/from \
           -v $2_master-cyb3rhq-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_ossec-logs:/from \
           -v $2_master-cyb3rhq-logs:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_ossec-queue:/from \
           -v $2_master-cyb3rhq-queue:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_ossec-var-multigroups:/from \
           -v $2_master-cyb3rhq-var-multigroups:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_ossec-integrations:/from \
           -v $2_master-cyb3rhq-integrations:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_ossec-active-response:/from \
           -v $2_master-cyb3rhq-active-response:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_ossec-agentless:/from \
           -v $2_master-cyb3rhq-agentless:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_ossec-wodles:/from \
           -v $2_master-cyb3rhq-wodles:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_filebeat-etc:/from \
           -v $2_master-filebeat-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_filebeat-var:/from \
           -v $2_master-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-api-configuration:/from \
           -v $2_worker-cyb3rhq-api-configuration:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-etc:/from \
           -v $2_worker-cyb3rhq-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-logs:/from \
           -v $2_worker-cyb3rhq-logs:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-queue:/from \
           -v $2_worker-cyb3rhq-queue:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-var-multigroups:/from \
           -v $2_worker-cyb3rhq-var-multigroups:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-integrations:/from \
           -v $2_worker-cyb3rhq-integrations:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-active-response:/from \
           -v $2_worker-cyb3rhq-active-response:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-agentless:/from \
           -v $2_worker-cyb3rhq-agentless:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-ossec-wodles:/from \
           -v $2_worker-cyb3rhq-wodles:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-filebeat-etc:/from \
           -v $2_worker-filebeat-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v cyb3rhq-docker_worker-filebeat-var:/from \
           -v $2_worker-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
