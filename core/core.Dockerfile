# Overridden from args-build-file.default.conf through CI & image.build.sh
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

FROM ${OCI_BASE_IMAGE}

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
ARG ENKLUM_FLAVOR="enklum-core"

# Envs From Args build
ENV \
  ENKLUM_USERNAME=${ENKLUM_USERNAME} \
  ENKLUM_WORKSPACE_DIR=${ENKLUM_WORKSPACE_DIR} \
  ENKLUM_GIT_USER_NAME="Smith Black" \
  ENKLUM_GIT_USER_EMAIL="smith@enklum.dev" \
  ENKLUM_DEFAULT_EDITOR="nvim" \
  ENKLUM_VERSION=${OCI_VERSION} \
  ENKLUM_FLAVOR=${ENKLUM_FLAVOR} \
  TZ="Europe/Paris" \
  TERM="xterm-256color" \
  COLORTERM="truecolor"

LABEL \
  name=${ENKLUM_FLAVOR} \
  version=${OCI_VERSION} \
  maintainer=${OCI_MAINTAINER} \
  description=${OCI_DESCRIPTION} \
  url=${OCI_REPO_URL} \
  base-image=${OCI_BASE_IMAGE} \
  base-image-url=${OCI_BASE_IMAGE_URL} \
  org.opencontainers.image.name=${ENKLUM_FLAVOR} \
  org.opencontainers.image.title=${OCI_TITLE} \
  org.opencontainers.image.description=${OCI_DESCRIPTION} \
  org.opencontainers.image.version=${OCI_VERSION} \
  org.opencontainers.image.created=${OCI_BUILD_DATE} \
  org.opencontainers.image.authors=${OCI_MAINTAINER} \
  org.opencontainers.image.url=${OCI_REPO_URL} \
  org.opencontainers.image.base.name=${OCI_BASE_IMAGE} \
  org.opencontainers.image.base.url=${OCI_BASE_IMAGE_URL}

# Switch to setup workspace for init & config
WORKDIR /setup/core/

# ---- Core Init ----
COPY ./core/ ./
RUN \
  echo "Creating ENKLUM image from ${OCI_BASE_IMAGE}..." && \
  # Apply system update before anything
  dnf upgrade -y && \
  # And core system package to continue
  dnf install -y dos2unix tini && \
  # Ensure linux format of core stuff & system & user execution
  find ./ -type f -exec dos2unix {} \; && chmod 755 -R ./ && \
  # Init system & os configuration
  bash ./system/dnf.install.sh && bash ./system/os.config.sh && \
  # Ensure proper rights on home resources & copy to real home folder before running scripts as user
  chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R ./res && cp -ar ./res/home/. /home/${ENKLUM_USERNAME} && \
  # Init user core config
  runuser -u ${ENKLUM_USERNAME} -- bash -c "./system/user.config.sh" && \
  # Install core tools & config them as user
  runuser -u ${ENKLUM_USERNAME} -- bash -c "./tools/tools.install.sh" && runuser -u ${ENKLUM_USERNAME} -- bash -c "./tools/tools.config.sh" && \
  # Drop setup
  rm -rf /setup

# ---- CMD ----
COPY ./shared /enklum
RUN \
  # Ensure linux format of setup stuff
  find /enklum -type f -exec dos2unix {} \; && \
  # Ensure proper rights
  chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R /enklum && chmod 755 -R /enklum

# Switch to default workspace directory
WORKDIR ${ENKLUM_WORKSPACE_DIR}

# Force default user instead of root
USER ${ENKLUM_USERNAME}

ENTRYPOINT ["/sbin/tini", "--", "/enklum/cmd/entrypoint.sh"]
