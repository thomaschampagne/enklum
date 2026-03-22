FROM ghcr.io/thomaschampagne/enklum-core:latest
# FROM enklum-core:latest

ARG ENKLUM_FLAVOR="enklum-full"
LABEL \
  name=${ENKLUM_FLAVOR} \
  org.opencontainers.image.name=${ENKLUM_FLAVOR}
ENV ENKLUM_FLAVOR=${ENKLUM_FLAVOR}

# Force default user instead of root
USER ${ENKLUM_USERNAME}

# Play Enklum upgrades First (sudo not supported in CI, switch to root for dnf)
# USER root
# RUN dnf upgrade -y
# USER ${ENKLUM_USERNAME}
# RUN mise self-update && mise upgrade && mise reshim && mise prune && mise cache clean

# TODO --- [START] IN CORE ----
# USER root
# COPY ./shared /enklum
# RUN \
#   # Ensure linux format of setup stuff
#   find /enklum -type f -exec dos2unix {} \; && \
#   # Ensure proper rights
#   chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R /enklum && chmod 755 -R /enklum
# USER ${ENKLUM_USERNAME}
# TODO --- [END] IN CORE ----

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