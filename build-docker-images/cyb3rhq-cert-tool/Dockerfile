# Cyb3rhq Docker Copyright (C) 2017, Cyb3rhq Inc. (License GPLv2)
FROM amazonlinux:2023

RUN yum install curl-minimal openssl -y &&\
yum clean all

WORKDIR /

COPY config/entrypoint.sh /

RUN chmod 700 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]