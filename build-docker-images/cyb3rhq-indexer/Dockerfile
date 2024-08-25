# Cyb3rhq Docker Copyright (C) 2017, Cyb3rhq Inc. (License GPLv2)
FROM amazonlinux:2023 AS builder

ARG CYB3RHQ_VERSION
ARG CYB3RHQ_TAG_REVISION

RUN yum install curl-minimal openssl xz tar findutils shadow-utils -y

COPY config/check_repository.sh /
RUN chmod 775 /check_repository.sh && \
    source /check_repository.sh

RUN yum install cyb3rhq-indexer-${CYB3RHQ_VERSION}-${CYB3RHQ_TAG_REVISION} -y && \
    yum clean all

COPY config/opensearch.yml /

COPY config/config.sh .

COPY config/config.yml /

RUN bash config.sh

################################################################################
# Build stage 1 (the actual Cyb3rhq indexer image):
#
# Copy cyb3rhq-indexer from stage 0
# Add entrypoint

################################################################################
FROM amazonlinux:2023

ENV USER="cyb3rhq-indexer" \
    GROUP="cyb3rhq-indexer" \
    NAME="cyb3rhq-indexer" \
    INSTALL_DIR="/usr/share/cyb3rhq-indexer"

# Set $JAVA_HOME
RUN echo "export JAVA_HOME=$INSTALL_DIR/jdk" >> /etc/profile.d/java_home.sh && \
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile.d/java_home.sh
ENV JAVA_HOME="$INSTALL_DIR/jdk"
ENV PATH=$PATH:$JAVA_HOME/bin:$INSTALL_DIR/bin

# Add k-NN lib directory to library loading path variable
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$INSTALL_DIR/plugins/opensearch-knn/lib"

RUN yum install curl-minimal shadow-utils findutils hostname -y

RUN getent group $GROUP || groupadd -r -g 1000 $GROUP

RUN useradd --system \
            --uid 1000 \
            --no-create-home \
            --home-dir $INSTALL_DIR \
            --gid $GROUP \
            --shell /sbin/nologin \
            --comment "$USER user" \
            $USER

WORKDIR $INSTALL_DIR

COPY config/entrypoint.sh /

COPY config/securityadmin.sh /

RUN chmod 700 /entrypoint.sh && chmod 700 /securityadmin.sh

RUN chown 1000:1000 /*.sh

COPY --from=builder --chown=1000:1000 /usr/share/cyb3rhq-indexer /usr/share/cyb3rhq-indexer
COPY --from=builder --chown=1000:1000 /etc/cyb3rhq-indexer /usr/share/cyb3rhq-indexer
COPY --from=builder --chown=0:0 /debian/cyb3rhq-indexer/usr/lib/systemd /usr/lib/systemd
COPY --from=builder --chown=0:0 /debian/cyb3rhq-indexer/usr/lib/sysctl.d /usr/lib/sysctl.d
COPY --from=builder --chown=0:0 /debian/cyb3rhq-indexer/usr/lib/tmpfiles.d /usr/lib/tmpfiles.d

RUN chown -R 1000:1000 /usr/share/cyb3rhq-indexer

RUN mkdir -p /var/lib/cyb3rhq-indexer && chown 1000:1000 /var/lib/cyb3rhq-indexer && \
    mkdir -p /usr/share/cyb3rhq-indexer/logs && chown 1000:1000 /usr/share/cyb3rhq-indexer/logs && \
    mkdir -p /run/cyb3rhq-indexer && chown 1000:1000 /run/cyb3rhq-indexer && \
    mkdir -p /var/log/cyb3rhq-indexer && chown 1000:1000 /var/log/cyb3rhq-indexer && \
    chmod 700 /usr/share/cyb3rhq-indexer && \
    chmod 600 /usr/share/cyb3rhq-indexer/jvm.options && \
    chmod 600 /usr/share/cyb3rhq-indexer/opensearch.yml

USER cyb3rhq-indexer

# Services ports
EXPOSE 9200

ENTRYPOINT ["/entrypoint.sh"]
# Dummy overridable parameter parsed by entrypoint
CMD ["opensearchwrapper"]