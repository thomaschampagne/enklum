# Overridden from argfile.default.conf through CI & image.build.sh
ARG ENKLUM_FEDORA_BASE_VERSION=latest
ARG ENKLUM_USERNAME="smith"
ARG ENKLUM_WORKSPACE_DIR="/workspace"

# OCI Args
ARG OCI_BASE_IMAGE=registry.fedoraproject.org/fedora-minimal:${ENKLUM_FEDORA_BASE_VERSION}
ARG OCI_BASE_IMAGE_URL=https://hub.docker.com/_/fedora
ARG OCI_TITLE=oci-enklum-image
ARG OCI_REPO_URL=https://github.com/thomaschampagne/enklum
ARG OCI_DESCRIPTION="A portable Fedora terminal-driven development forge"
ARG OCI_MAINTAINER="Thomas Champagne"

FROM ${OCI_BASE_IMAGE} as core

ARG OCI_BASE_IMAGE
ARG OCI_BASE_IMAGE_URL
ARG OCI_TITLE
ARG OCI_DESCRIPTION
ARG OCI_VERSION
ARG OCI_MAINTAINER
ARG OCI_REPO_URL
ARG OCI_BUILD_DATE
ARG ENKLUM_USERNAME
ARG ENKLUM_WORKSPACE_DIR

# Envs From Args build
ENV \
  ENKLUM_USERNAME=${ENKLUM_USERNAME} \
  ENKLUM_WORKSPACE_DIR=${ENKLUM_WORKSPACE_DIR} \
  ENKLUM_GIT_USER_NAME="Smith Black" \
  ENKLUM_GIT_USER_EMAIL="smith@enklum.dev" \
  ENKLUM_DEFAULT_EDITOR="hx" \
  ENKLUM_VERSION=${OCI_VERSION} \
  TZ="Europe/Paris" \
  TERM="xterm-256color" \
  COLORTERM="truecolor"

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

# Switch to setup workspace for init & config
WORKDIR /setup/core/system

# ---- Core Init ----
COPY ./core/system ./
RUN \
  echo "Creating ENKLUM image from ${OCI_BASE_IMAGE}..." && \
  # Apply system update before anything
  dnf upgrade -y && \
  # And core system package to continue
  dnf install -y dos2unix tini && \
  # Ensure linux format of setup stuff
  find ./ -type f -exec dos2unix {} \; && \
  # Init system & os configuration
  bash ./dnf.install.sh && bash ./os.config.sh

WORKDIR /setup/core/res
COPY ./core/res ./
RUN \
  # Ensure linux format & proper rights on home resources & copy to real home folder
  find ./ -type f -exec dos2unix {} \; && \
  chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R ./ && chmod 755 -R ./ && \
  cp -ar . /home/${ENKLUM_USERNAME}

# ---- CMD ----
COPY ./shared/cmd /enklum/cmd
RUN \
  # Ensure linux format of setup stuff
  find /enklum/cmd -type f -exec dos2unix {} \; && \
  # Ensure proper rights
  chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R /enklum/cmd && chmod 755 -R /enklum/cmd

# # ---- Base Tools Init ----
# COPY ./setup/tools ./tools
# COPY ./resources/home ./resources/home
# RUN \
#   # Ensure linux format & proper rights on tools scripts
#   find ./tools -type f -exec dos2unix {} \; && chmod -R 755 ./tools && \
#   # Ensure linux format & proper rights on home resources & copy to real home folder
#   find ./resources/home -type f -exec dos2unix {} \; && \
#   chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R ./resources/home && chmod 755 -R ./resources/home && \
#   cp -ar ./resources/home/. /home/${ENKLUM_USERNAME} && \
#   # Init tools installations & configuration as user
#   runuser -u ${ENKLUM_USERNAME} -- zsh -ic "./tools/base/packages.init.sh" && \
#   runuser -u ${ENKLUM_USERNAME} -- zsh -ic "./tools/base/user.config.sh" && \
#   # Clean up
#   rm -rf /setup

# # ---- Cli Tools setup ----
# COPY ./setup/cmd /enklum/cmd
# RUN \
#   # Ensure linux format of setup stuff
#   find /enklum/cmd -type f -exec dos2unix {} \; && \
#   # Ensure proper rights
#   chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R /enklum/cmd && chmod 755 -R /enklum/cmd

# Switch to default workspace directory
WORKDIR ${ENKLUM_WORKSPACE_DIR}

# Force default user instead of root
USER ${ENKLUM_USERNAME}

ENTRYPOINT ["/sbin/tini", "--", "/enklum/cmd/entrypoint.sh"]
# CMD ["/bin/sh", "-c", "sleep infinity"]

# FROM core as tools_installs

# COPY source dest