# Cyb3rhq Docker Copyright (C) 2017, Cyb3rhq Inc. (License GPLv2)
FROM amazonlinux:2023 AS builder

ARG CYB3RHQ_VERSION
ARG CYB3RHQ_TAG_REVISION
ARG CYB3RHQ_UI_REVISION
ARG INSTALL_DIR=/usr/share/cyb3rhq-dashboard

# Update and install dependencies
RUN yum install curl-minimal libcap openssl -y

COPY config/check_repository.sh /
RUN chmod 775 /check_repository.sh && \
    source /check_repository.sh

RUN yum install cyb3rhq-dashboard-${CYB3RHQ_VERSION}-${CYB3RHQ_TAG_REVISION} -y && \
    yum clean all

# Create and set permissions to data directories
RUN mkdir -p $INSTALL_DIR/data/cyb3rhq && chmod -R 775 $INSTALL_DIR/data/cyb3rhq
RUN mkdir -p $INSTALL_DIR/data/cyb3rhq/config && chmod -R 775 $INSTALL_DIR/data/cyb3rhq/config
RUN mkdir -p $INSTALL_DIR/data/cyb3rhq/logs && chmod -R 775 $INSTALL_DIR/data/cyb3rhq/logs
COPY config/cyb3rhq.yml $INSTALL_DIR/data/cyb3rhq/config/

# Generate certificates
COPY config/config.sh .
COPY config/config.yml /
RUN bash config.sh

################################################################################
# Build stage 1 (the current Cyb3rhq dashboard image):
#
# Copy cyb3rhq-dashboard from stage 0
# Add entrypoint
# Add cyb3rhq_app_config
################################################################################
FROM amazonlinux:2023

# Set environment variables
ENV USER="cyb3rhq-dashboard" \
    GROUP="cyb3rhq-dashboard" \
    NAME="cyb3rhq-dashboard" \
    INSTALL_DIR="/usr/share/cyb3rhq-dashboard"

# Set Cyb3rhq app variables
ENV PATTERN="" \
    CHECKS_PATTERN="" \
    CHECKS_TEMPLATE="" \
    CHECKS_API="" \
    CHECKS_SETUP="" \
    APP_TIMEOUT="" \
    API_SELECTOR="" \
    IP_SELECTOR="" \
    IP_IGNORE="" \
    CYB3RHQ_MONITORING_ENABLED="" \
    CYB3RHQ_MONITORING_FREQUENCY="" \
    CYB3RHQ_MONITORING_SHARDS="" \
    CYB3RHQ_MONITORING_REPLICAS=""

# Update and install dependencies
RUN yum install shadow-utils -y

# Create cyb3rhq-dashboard user and group
RUN getent group $GROUP || groupadd -r -g 1000 $GROUP
RUN useradd --system \
            --uid 1000 \
            --no-create-home \
            --home-dir $INSTALL_DIR \
            --gid $GROUP \
            --shell /sbin/nologin \
            --comment "$USER user" \
            $USER

# Copy and set permissions to scripts
COPY config/entrypoint.sh /
COPY config/cyb3rhq_app_config.sh /
RUN chmod 700 /entrypoint.sh
RUN chmod 700 /cyb3rhq_app_config.sh
RUN chown 1000:1000 /*.sh

# Copy Install dir from builder to current image
COPY --from=builder --chown=1000:1000 $INSTALL_DIR $INSTALL_DIR

# Create custom directory
RUN mkdir -p /usr/share/cyb3rhq-dashboard/plugins/cyb3rhq/public/assets/custom
RUN chown 1000:1000 /usr/share/cyb3rhq-dashboard/plugins/cyb3rhq/public/assets/custom

# Set $JAVA_HOME
RUN echo "export JAVA_HOME=$INSTALL_DIR/jdk" >> /etc/profile.d/java_home.sh && \
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile.d/java_home.sh
ENV JAVA_HOME=$INSTALL_DIR/jdk
ENV PATH=$PATH:$JAVA_HOME/bin:$INSTALL_DIR/bin

# Add k-NN lib directory to library loading path variable
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$INSTALL_DIR/plugins/opensearch-knn/lib"

# Set workdir and user
WORKDIR $INSTALL_DIR
USER cyb3rhq-dashboard

# Services ports
EXPOSE 443

ENTRYPOINT [ "/entrypoint.sh" ]

CMD ["opensearch-dashboards"]
