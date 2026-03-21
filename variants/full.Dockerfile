FROM ghcr.io/thomaschampagne/enklum-core:latest
# FROM enklum-core:latest

# TODO --- [START] IN CORE ----
USER root
COPY ./shared /enklum
RUN \
  # Ensure linux format of setup stuff
  find /enklum -type f -exec dos2unix {} \; && \
  # Ensure proper rights
  chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R /enklum && chmod 755 -R /enklum

USER ${ENKLUM_USERNAME}
# TODO --- [END] IN CORE ----

COPY --chown=${ENKLUM_USERNAME}:${ENKLUM_USERNAME} \
  # ###############  
  # #### FROM #####
  # ###############
  # SHELL - oh-my-posh shell enhancer
  ./features/cli/oh-my-posh \
  # LSP:json
  ./features/languages/json \
  # LSP:yaml
  ./features/languages/yaml \
  # Node + JS/TS + LSP + Formatter
  ./features/languages/js-ts \
  # BunJS
  ./features/runtimes/bun \
  # GoLang + LSP + Formatter
  ./features/languages/golang \
  # #############
  # #### TO ####
  # #############
  /home/${ENKLUM_USERNAME}/.tmp/features/

# Bulk apply features
RUN bash /enklum/feats.install.sh --features-folder ~/.tmp