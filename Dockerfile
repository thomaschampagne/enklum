
ARG OCI_BASE_IMAGE=fedora:43 # TODO:later Set base version as a build ARG
ARG OCI_BASE_IMAGE_URL=https://hub.docker.com/_/fedora
ARG OCI_TITLE=oci-vault-image
ARG OCI_REPO_URL=https://github.com/thomaschampagne/kajko
# TODO ...
ARG OCI_DESCRIPTION="...TODO...."
ARG OCI_MAINTAINER="Thomas Champagne"
ARG SYSTEM_USERNAME="dev"
ARG DEFAULT_WORKSPACE_DIR="/workspace"

FROM ${OCI_BASE_IMAGE}

ARG OCI_BASE_IMAGE
ARG OCI_BASE_IMAGE_URL
ARG OCI_TITLE
ARG OCI_DESCRIPTION
ARG OCI_MAINTAINER
ARG OCI_REPO_URL
ARG OCI_BUILD_DATE
ARG SYSTEM_USERNAME
ARG DEFAULT_WORKSPACE_DIR

ENV OCI_BASE_IMAGE=${OCI_BASE_IMAGE}
ENV OCI_BASE_IMAGE_URL=${OCI_BASE_IMAGE_URL}
ENV OCI_TITLE=${OCI_TITLE}
ENV OCI_DESCRIPTION=${OCI_DESCRIPTION}
ENV OCI_MAINTAINER=${OCI_MAINTAINER}
ENV OCI_REPO_URL=${OCI_REPO_URL}
ENV OCI_BUILD_DATE=${OCI_BUILD_DATE}

# Envs From Args build
ENV SYSTEM_USERNAME=${SYSTEM_USERNAME}
ENV DEFAULT_WORKSPACE_DIR=${DEFAULT_WORKSPACE_DIR}

# Custom Envs
ENV TERM="xterm-256color"
ENV COLORTERM="truecolor"
ENV GIT_NAME="Your Name"
ENV GIT_EMAIL="your@email.com"

LABEL \
    maintainer=${OCI_MAINTAINER} \
    description=${OCI_DESCRIPTION} \
    url=${OCI_REPO_URL} \
    base-image=${OCI_BASE_IMAGE} \
    base-image-url=${OCI_BASE_IMAGE_URL} \
    org.opencontainers.image.title=${OCI_TITLE} \
    org.opencontainers.image.description=${OCI_DESCRIPTION} \
    org.opencontainers.image.created=${OCI_BUILD_DATE} \
    org.opencontainers.image.authors=${OCI_MAINTAINER} \
    org.opencontainers.image.url=${OCI_REPO_URL} \
    org.opencontainers.image.base.name=${OCI_BASE_IMAGE} \
    org.opencontainers.image.base.url=${OCI_BASE_IMAGE_URL}

# TODO comments
WORKDIR /setup

# TODO comments
COPY ./src/core/elevated.init.sh ./core/elevated.init.sh
COPY ./src/core/user.setup.sh ./core/user.setup.sh

# TODO comments
RUN \
    # TODO comments
    sh ./core/elevated.init.sh # && \
    # TODO comments
    # rm -rf ./core

WORKDIR ${DEFAULT_WORKSPACE_DIR}

USER ${SYSTEM_USERNAME}

CMD ["/bin/sh", "-c", "sleep infinity"]
