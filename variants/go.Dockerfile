# TODO Use instead: ghcr.io/thomaschampagne/enklum-core:latest
FROM enklum-core:latest 

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


COPY ./features/oh-my-posh ~/.tmp-feats/oh-my-posh
COPY ./features/go ~/.tmp-feats/go

RUN bash /enklum/feats.install.sh --features-folder ~/.tmp-feats