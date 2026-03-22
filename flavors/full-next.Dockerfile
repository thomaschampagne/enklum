FROM enklum-full:latest
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

COPY --parents --chown=${ENKLUM_USERNAME}:${ENKLUM_USERNAME} \
  # #### COPY OF BELOW HOST FOLDERS #####
  ./features/runtimes/node-lts \
  #---- # TODO REport back these !
  #----
  # #### TO IMAGE AT BELOW LOCATION ####
  /home/${ENKLUM_USERNAME}/.tmp/

# Bulk apply features
RUN bash /enklum/feats.install.sh --features-folder ~/.tmp
