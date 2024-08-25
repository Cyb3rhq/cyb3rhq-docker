REPOSITORY="packages.wazuh.com/4.x"
CYB3RHQ_CURRENT_VERSION=$(curl --silent https://api.github.com/repos/cyb3rhq/cyb3rhq/releases/latest | grep '["]tag_name["]:' | sed -E 's/.*\"([^\"]+)\".*/\1/' | cut -c 2-)
MAJOR_BUILD=$(echo $CYB3RHQ_VERSION | cut -d. -f1)
MID_BUILD=$(echo $CYB3RHQ_VERSION | cut -d. -f2)
MINOR_BUILD=$(echo $CYB3RHQ_VERSION | cut -d. -f3)
MAJOR_CURRENT=$(echo $CYB3RHQ_CURRENT_VERSION | cut -d. -f1)
MID_CURRENT=$(echo $CYB3RHQ_CURRENT_VERSION | cut -d. -f2)
MINOR_CURRENT=$(echo $CYB3RHQ_CURRENT_VERSION | cut -d. -f3)

## check version to use the correct repository
if [ "$MAJOR_BUILD" -gt "$MAJOR_CURRENT" ]; then
  REPOSITORY="packages-dev.wazuh.com/pre-release"
elif [ "$MAJOR_BUILD" -eq "$MAJOR_CURRENT" ]; then
  if [ "$MID_BUILD" -gt "$MID_CURRENT" ]; then
    REPOSITORY="packages-dev.wazuh.com/pre-release"
  elif [ "$MID_BUILD" -eq "$MID_CURRENT" ]; then
    if [ "$MINOR_BUILD" -gt "$MINOR_CURRENT" ]; then
      REPOSITORY="packages-dev.wazuh.com/pre-release"
    fi
  fi
fi

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/${FILEBEAT_CHANNEL}-${FILEBEAT_VERSION}-x86_64.rpm &&\
yum install -y ${FILEBEAT_CHANNEL}-${FILEBEAT_VERSION}-x86_64.rpm && rm -f ${FILEBEAT_CHANNEL}-${FILEBEAT_VERSION}-x86_64.rpm && \
curl -s https://${REPOSITORY}/filebeat/${CYB3RHQ_FILEBEAT_MODULE} | tar -xvz -C /usr/share/filebeat/module