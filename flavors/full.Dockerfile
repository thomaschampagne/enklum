FROM ghcr.io/thomaschampagne/enklum-core:latest
# FROM enklum-core:latest

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

ARG ENKLUM_FLAVOR="full"

# ENV ENKLUM_FLAVOR=${ENKLUM_FLAVOR} # TODO Uncomment if ENV flavor is wrong here (=> not "full")

LABEL \
  name=enklum-${ENKLUM_FLAVOR}

USER root
RUN /enklum/cmd/enklum --update
USER ${ENKLUM_USERNAME}

# RUN whoami && zsh -ic "enklum --update"

# COPY --parents --chown=${ENKLUM_USERNAME}:${ENKLUM_USERNAME} \
#   # #### COPY OF BELOW HOST FOLDERS #####
#   # SHELL Enhancer - oh-my-posh shell enhancer
#   ./features/cli/oh-my-posh \
#   # NodeJS required by many common LSPs (json, yaml, bash, typescript/javascript, ...)
#   ./features/runtimes/node-lts \
#   # LSP:json
#   ./features/languages/json \
#   # LSP:yaml
#   ./features/languages/yaml \
#   # LSP:bash
#   ./features/languages/bash \
#   # Node + JS/TS + LSP + Formatter
#   ./features/languages/js-ts \
#   # BunJS
#   ./features/runtimes/bun \
#   # GoLang + LSP + Formatter
#   ./features/languages/golang \
#   # #### TO IMAGE AT BELOW LOCATION ####
#   /home/${ENKLUM_USERNAME}/.tmp/

# # Bulk apply features
# RUN bash /enklum/feats.install.sh --features-folder ~/.tmp
