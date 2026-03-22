FROM ghcr.io/thomaschampagne/enklum-core:latest
# FROM enklum-core:latest

ARG ENKLUM_NAME="enklum-full"

LABEL \
  name=${ENKLUM_NAME} \
  org.opencontainers.image.name=${ENKLUM_NAME}

# TODO Uncomment if ENV flavor is wrong here (=> not "full")
# ENV ENKLUM_FLAVOR=${ENKLUM_FLAVOR}

USER root

# TODO --- [START] IN CORE ----
# COPY ./shared /enklum
# RUN \
#   # Ensure linux format of setup stuff
#   find /enklum -type f -exec dos2unix {} \; && \
#   # Ensure proper rights
#   chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R /enklum && chmod 755 -R /enklum
# TODO --- [END] IN CORE ----

# Play Enklum upgrades First
RUN runuser -u ${ENKLUM_USERNAME} -- bash -c "/enklum/cmd/enklum --update"

COPY --parents --chown=${ENKLUM_USERNAME}:${ENKLUM_USERNAME} \
  # #### COPY OF BELOW HOST FOLDERS #####
  # SHELL Enhancer - oh-my-posh shell enhancer
  ./features/cli/oh-my-posh \
  # NodeJS required by many common LSPs (json, yaml, bash, typescript/javascript, ...)
  ./features/runtimes/node-lts \
  # LSP:json
  ./features/languages/json \
  # LSP:yaml
  ./features/languages/yaml \
  # LSP:bash
  ./features/languages/bash \
  # Node + JS/TS + LSP + Formatter
  ./features/languages/js-ts \
  # BunJS
  ./features/runtimes/bun \
  # GoLang + LSP + Formatter
  ./features/languages/golang \
  # #### TO IMAGE AT BELOW LOCATION ####
  /home/${ENKLUM_USERNAME}/.tmp/

# Bulk apply features
RUN bash /enklum/feats.install.sh --features-folder /home/${ENKLUM_USERNAME}/.tmp

USER ${ENKLUM_USERNAME}