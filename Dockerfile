
ARG OCI_BASE_IMAGE=fedora:43 # TODO:later Set base version as a build ARG # TODO Can be in argfile.conf ??
ARG OCI_BASE_IMAGE_URL=https://hub.docker.com/_/fedora
ARG OCI_TITLE=oci-vault-image
ARG OCI_REPO_URL=https://github.com/thomaschampagne/kajko
ARG OCI_DESCRIPTION="...TODO...." # TODO ...
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
ARG SYSTEM_USERNAME # TODO Can be in argfile.conf file => "dev"
ARG DEFAULT_WORKSPACE_DIR # TODO Can be in argfile.conf file => "/workspace"
ARG GITHUB_TOKEN # TODO Can be in argfile.conf file

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
ENV GITHUB_TOKEN=${GITHUB_TOKEN}

# Custom Envs # TODO Can be in .env file
ENV GIT_NAME="Your Name"
ENV GIT_EMAIL="your@email.com"
ENV TZ="Europe/Paris"

# System enforced envs
ENV TERM="xterm-256color"
ENV COLORTERM="truecolor"

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
WORKDIR /setup

# TODO Remove safe integrity layer for image build cache usage at the (COPY + RUN) ?
# TODO Add Pre-system update scripts loop

RUN \
  # Apply system update before anything
  dnf upgrade -y && \
  # And core system package to continue
  dnf install -y dos2unix

###### Setup SYSTEM side & config #######
COPY ./setup/system/packages.init.sh ./system/packages.init.sh
RUN dos2unix ./system/packages.init.sh && bash ./system/packages.init.sh

COPY ./setup/system/os.config.sh ./system/os.config.sh
RUN dos2unix ./system/os.config.sh && bash ./system/os.config.sh

COPY ./setup/system/resources/.zshrc /home/${SYSTEM_USERNAME}/.zshrc
RUN dos2unix /home/${SYSTEM_USERNAME}/.zshrc && \
  chown ${SYSTEM_USERNAME}:${SYSTEM_USERNAME} /home/${SYSTEM_USERNAME}/.zshrc && \
  chmod 644 /home/${SYSTEM_USERNAME}/.zshrc

###### Setup TOOLS BASELINE & Config #######
COPY ./setup/tools/base/packages.init.sh ./setup/tools/base/packages.init.sh
RUN \
  # Run base tool package as user
  dos2unix ./setup/tools/base/packages.init.sh && \
  runuser -u ${SYSTEM_USERNAME} -- zsh ./setup/tools/base/packages.init.sh

COPY ./setup/tools/base/user.config.sh ./tools/base/user.config.sh
RUN dos2unix ./tools/base/user.config.sh && runuser -u ${SYSTEM_USERNAME} -- zsh ./tools/base/user.config.sh

# Copy base resources default files
COPY ./setup/tools/base/resources/.config/ /home/${SYSTEM_USERNAME}/
RUN dos2unix /home/${SYSTEM_USERNAME}/.config/* && \
  chown ${SYSTEM_USERNAME}:${SYSTEM_USERNAME} /home/${SYSTEM_USERNAME}/.config/

###### Setup DEV TOOLS USER & config #######
# TODO Copy all *.sh sort them by filename and run in order ? @see https://github.com/thomaschampagne/oci-images/blob/main/cloud-domain/entrypoint.sh#L144

# Switch to default workspace directory
WORKDIR ${DEFAULT_WORKSPACE_DIR}

# TODO Add entrypoint file @see https://github.com/thomaschampagne/oci-images/blob/main/cloud-domain/entrypoint.sh#L140 => L161
# COPY ./entrypoint.sh /entrypoint.sh

# ... and default user
USER ${SYSTEM_USERNAME}

# ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
CMD ["/bin/sh", "-c", "sleep infinity"]
