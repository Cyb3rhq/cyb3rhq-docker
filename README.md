# Cyb3rhq containers for Docker

[![Slack](https://img.shields.io/badge/slack-join-blue.svg)](https://wazuh.com/community/join-us-on-slack/)
[![Email](https://img.shields.io/badge/email-join-blue.svg)](https://groups.google.com/forum/#!forum/cyb3rhq)
[![Documentation](https://img.shields.io/badge/docs-view-green.svg)](https://documentation.wazuh.com)
[![Documentation](https://img.shields.io/badge/web-view-green.svg)](https://wazuh.com)

In this repository you will find the containers to run:

* Cyb3rhq manager: it runs the Cyb3rhq manager, Cyb3rhq API and Filebeat OSS
* Cyb3rhq dashboard: provides a web user interface to browse through alert data and allows you to visualize the agents configuration and status.
* Cyb3rhq indexer: Cyb3rhq indexer container (working as a single-node cluster or as a multi-node cluster). **Be aware to increase the `vm.max_map_count` setting, as it's detailed in the [Cyb3rhq documentation](https://documentation.wazuh.com/current/docker/cyb3rhq-container.html#increase-max-map-count-on-your-host-linux).**

The folder `build-docker-images` contains a README explaining how to build the Cyb3rhq images and the necessary assets.
The folder `indexer-certs-creator` contains a README explaining how to create the certificates creator tool and the necessary assets.
The folder `single-node` contains a README explaining how to run a Cyb3rhq environment with one Cyb3rhq manager, one Cyb3rhq indexer, and one Cyb3rhq dashboard.
The folder `multi-node` contains a README explaining how to run a Cyb3rhq environment with two Cyb3rhq managers, three Cyb3rhq indexers, and one Cyb3rhq dashboard.

## Documentation

* [Cyb3rhq full documentation](http://documentation.wazuh.com)
* [Cyb3rhq documentation for Docker](https://documentation.wazuh.com/current/docker/index.html)
* [Docker Hub](https://hub.docker.com/u/cyb3rhq)


### Setup SSL certificate

Before starting the environment it is required to provide an SSL certificate (or just generate one self-signed).

Documentation on how to provide these two can be found at [Cyb3rhq Docker Documentation](https://documentation.wazuh.com/current/docker/cyb3rhq-container.html#production-deployment).


## Environment Variables

Default values are included when available.

### Cyb3rhq
```
API_USERNAME="cyb3rhq-wui"                            # Cyb3rhq API username
API_PASSWORD="MyS3cr37P450r.*-"                     # Cyb3rhq API password - Must comply with requirements
                                                    # (8+ length, uppercase, lowercase, special chars)

INDEXER_URL=https://cyb3rhq.indexer:9200              # Cyb3rhq indexer URL
INDEXER_USERNAME=admin                              # Cyb3rhq indexer Username
INDEXER_PASSWORD=SecretPassword                     # Cyb3rhq indexer Password
FILEBEAT_SSL_VERIFICATION_MODE=full                 # Filebeat SSL Verification mode (full or none)
SSL_CERTIFICATE_AUTHORITIES=""                      # Path of Filebeat SSL CA
SSL_CERTIFICATE=""                                  # Path of Filebeat SSL Certificate
SSL_KEY=""                                          # Path of Filebeat SSL Key
```

### Dashboard
```
PATTERN="cyb3rhq-alerts-*"        # Default index pattern to use

CHECKS_PATTERN=true             # Defines which checks must be considered by the healthcheck
CHECKS_TEMPLATE=true            # step once the Cyb3rhq app starts. Values must be true or false
CHECKS_API=true
CHECKS_SETUP=true

APP_TIMEOUT=20000               # Defines maximum timeout to be used on the Cyb3rhq app requests

API_SELECTOR=true               Defines if the user is allowed to change the selected API directly from the Cyb3rhq app top menu
IP_SELECTOR=true                # Defines if the user is allowed to change the selected index pattern directly from the Cyb3rhq app top menu
IP_IGNORE="[]"                  # List of index patterns to be ignored

DASHBOARD_USERNAME=kibanaserver     # Custom user saved in the dashboard keystore
DASHBOARD_PASSWORD=kibanaserver     # Custom password saved in the dashboard keystore
CYB3RHQ_MONITORING_ENABLED=true       # Custom settings to enable/disable cyb3rhq-monitoring indices
CYB3RHQ_MONITORING_FREQUENCY=900      # Custom setting to set the frequency for cyb3rhq-monitoring indices cron task
CYB3RHQ_MONITORING_SHARDS=2           # Configure cyb3rhq-monitoring-* indices shards and replicas
CYB3RHQ_MONITORING_REPLICAS=0         ##
```

## Directory structure

    ├── build-docker-images
    │   ├── build-images.sh
    │   ├── build-images.yml
    │   ├── README.md
    │   ├── cyb3rhq-dashboard
    │   │   ├── config
    │   │   │   ├── config.sh
    │   │   │   ├── config.yml
    │   │   │   ├── dl_base.sh
    │   │   │   ├── entrypoint.sh
    │   │   │   ├── install_cyb3rhq_app.sh
    │   │   │   ├── opensearch_dashboards.yml
    │   │   │   ├── cyb3rhq_app_config.sh
    │   │   │   └── cyb3rhq.yml
    │   │   └── Dockerfile
    │   ├── cyb3rhq-indexer
    │   │   ├── config
    │   │   │   ├── action_groups.yml
    │   │   │   ├── config.sh
    │   │   │   ├── config.yml
    │   │   │   ├── entrypoint.sh
    │   │   │   ├── internal_users.yml
    │   │   │   ├── opensearch.yml
    │   │   │   ├── roles_mapping.yml
    │   │   │   ├── roles.yml
    │   │   │   └── securityadmin.sh
    │   │   └── Dockerfile
    │   └── cyb3rhq-manager
    │       ├── config
    │       │   ├── check_repository.sh
    │       │   ├── create_user.py
    │       │   ├── etc
    │       │   │   ├── cont-init.d
    │       │   │   │   ├── 0-cyb3rhq-init
    │       │   │   │   ├── 1-config-filebeat
    │       │   │   │   └── 2-manager
    │       │   │   └── services.d
    │       │   │       ├── filebeat
    │       │   │       │   ├── finish
    │       │   │       │   └── run
    │       │   │       └── ossec-logs
    │       │   │           └── run
    │       │   ├── filebeat_module.sh
    │       │   ├── filebeat.yml
    │       │   ├── permanent_data.env
    │       │   └── permanent_data.sh
    │       └── Dockerfile
    ├── CHANGELOG.md
    ├── indexer-certs-creator
    │   ├── config
    │   │   └── entrypoint.sh
    │   ├── Dockerfile
    │   └── README.md
    ├── LICENSE
    ├── multi-node
    │   ├── config
    │   │   ├── certs.yml
    │   │   ├── nginx
    │   │   │   └── nginx.conf
    │   │   ├── cyb3rhq_cluster
    │   │   │   ├── cyb3rhq_manager.conf
    │   │   │   └── cyb3rhq_worker.conf
    │   │   ├── cyb3rhq_dashboard
    │   │   │   ├── opensearch_dashboards.yml
    │   │   │   └── cyb3rhq.yml
    │   │   └── cyb3rhq_indexer
    │   │       ├── internal_users.yml
    │   │       ├── cyb3rhq1.indexer.yml
    │   │       ├── cyb3rhq2.indexer.yml
    │   │       └── cyb3rhq3.indexer.yml
    │   ├── docker-compose.yml
    │   ├── generate-indexer-certs.yml
    │   ├── Migration-to-Cyb3rhq-4.4.md
    │   ├── README.md
    │   └── volume-migrator.sh
    ├── README.md
    ├── SECURITY.md
    ├── single-node
    │   ├── config
    │   │   ├── certs.yml
    │   │   ├── cyb3rhq_cluster
    │   │   │   └── cyb3rhq_manager.conf
    │   │   ├── cyb3rhq_dashboard
    │   │   │   ├── opensearch_dashboards.yml
    │   │   │   └── cyb3rhq.yml
    │   │   └── cyb3rhq_indexer
    │   │       ├── internal_users.yml
    │   │       └── cyb3rhq.indexer.yml
    │   ├── docker-compose.yml
    │   ├── generate-indexer-certs.yml
    │   └── README.md
    └── VERSION


## Branches

* `master` branch contains the latest code, be aware of possible bugs on this branch.
* `stable` branch corresponds to the last Cyb3rhq stable version.

## Compatibility Matrix

| Cyb3rhq version | ODFE    | XPACK  |
|---------------|---------|--------|
| v5.0.0        |         |        |
| v4.10.0       |         |        |
| v4.9.1        |         |        |
| v4.9.0        |         |        |
| v4.8.2        |         |        |
| v4.8.1        |         |        |
| v4.8.0        |         |        |
| v4.7.5        |         |        |
| v4.7.4        |         |        |
| v4.7.3        |         |        |
| v4.7.2        |         |        |
| v4.7.1        |         |        |
| v4.7.0        |         |        |
| v4.6.0        |         |        |
| v4.5.4        |         |        |
| v4.5.3        |         |        |
| v4.5.2        |         |        |
| v4.5.1        |         |        |
| v4.5.0        |         |        |
| v4.4.5        |         |        |
| v4.4.4        |         |        |
| v4.4.3        |         |        |
| v4.4.2        |         |        |
| v4.4.1        |         |        |
| v4.4.0        |         |        |
| v4.3.11       |         |        |
| v4.3.10       |         |        |
| v4.3.9        |         |        |
| v4.3.8        |         |        |
| v4.3.7        |         |        |
| v4.3.6        |         |        |
| v4.3.5        |         |        |
| v4.3.4        |         |        |
| v4.3.3        |         |        |
| v4.3.2        |         |        |
| v4.3.1        |         |        |
| v4.3.0        |         |        |
| v4.2.7        | 1.13.2  | 7.11.2 |
| v4.2.6        | 1.13.2  | 7.11.2 |
| v4.2.5        | 1.13.2  | 7.11.2 |
| v4.2.4        | 1.13.2  | 7.11.2 |
| v4.2.3        | 1.13.2  | 7.11.2 |
| v4.2.2        | 1.13.2  | 7.11.2 |
| v4.2.1        | 1.13.2  | 7.11.2 |
| v4.2.0        | 1.13.2  | 7.10.2 |
| v4.1.5        | 1.13.2  | 7.10.2 |
| v4.1.4        | 1.12.0  | 7.10.2 |
| v4.1.3        | 1.12.0  | 7.10.2 |
| v4.1.2        | 1.12.0  | 7.10.2 |
| v4.1.1        | 1.12.0  | 7.10.2 |
| v4.1.0        | 1.12.0  | 7.10.2 |
| v4.0.4        | 1.11.0  |        |
| v4.0.3        | 1.11.0  |        |
| v4.0.2        | 1.11.0  |        |
| v4.0.1        | 1.11.0  |        |
| v4.0.0        | 1.10.1  |        |

## Credits and Thank you

These Docker containers are based on:

*  "deviantony" dockerfiles which can be found at [https://github.com/deviantony/docker-elk](https://github.com/deviantony/docker-elk)
*  "xetus-oss" dockerfiles, which can be found at [https://github.com/xetus-oss/docker-ossec-server](https://github.com/xetus-oss/docker-ossec-server)

We thank them and everyone else who has contributed to this project.

## License and copyright

Cyb3rhq Docker Copyright (C) 2017, Cyb3rhq Inc. (License GPLv2)

## Web references

[Cyb3rhq website](http://wazuh.com)
