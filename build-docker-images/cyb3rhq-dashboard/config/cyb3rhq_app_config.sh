#!/bin/bash
# Cyb3rhq Docker Copyright (C) 2017, Cyb3rhq Inc. (License GPLv2)

cyb3rhq_url="${CYB3RHQ_API_URL:-https://cyb3rhq}"
cyb3rhq_port="${API_PORT:-55000}"
api_username="${API_USERNAME:-cyb3rhq-wui}"
api_password="${API_PASSWORD:-cyb3rhq-wui}"
api_run_as="${RUN_AS:-false}"

dashboard_config_file="/usr/share/cyb3rhq-dashboard/data/cyb3rhq/config/cyb3rhq.yml"

declare -A CONFIG_MAP=(
  [pattern]=$PATTERN
  [checks.pattern]=$CHECKS_PATTERN
  [checks.template]=$CHECKS_TEMPLATE
  [checks.api]=$CHECKS_API
  [checks.setup]=$CHECKS_SETUP
  [timeout]=$APP_TIMEOUT
  [api.selector]=$API_SELECTOR
  [ip.selector]=$IP_SELECTOR
  [ip.ignore]=$IP_IGNORE
  [cyb3rhq.monitoring.enabled]=$CYB3RHQ_MONITORING_ENABLED
  [cyb3rhq.monitoring.frequency]=$CYB3RHQ_MONITORING_FREQUENCY
  [cyb3rhq.monitoring.shards]=$CYB3RHQ_MONITORING_SHARDS
  [cyb3rhq.monitoring.replicas]=$CYB3RHQ_MONITORING_REPLICAS
)

for i in "${!CONFIG_MAP[@]}"
do
    if [ "${CONFIG_MAP[$i]}" != "" ]; then
        sed -i 's/.*#'"$i"'.*/'"$i"': '"${CONFIG_MAP[$i]}"'/' $dashboard_config_file
    fi
done


grep -q 1513629884013 $dashboard_config_file
_config_exists=$?

if [[ $_config_exists -ne 0 ]]; then
cat << EOF >> $dashboard_config_file
hosts:
  - 1513629884013:
      url: $cyb3rhq_url
      port: $cyb3rhq_port
      username: $api_username
      password: $api_password
      run_as: $api_run_as
EOF
else
  echo "Cyb3rhq APP already configured"
fi

