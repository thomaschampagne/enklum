FROM enklum-core:latest

# TODO --- [START] IN CORE ----

# TODO TMP: Drop 
USER root

COPY ./shared/cmd/features.installer.sh /enklum/cmd
RUN \
  # Ensure linux format of setup stuff
  find /enklum/cmd -type f -exec dos2unix {} \; && \
  # Ensure proper rights
  chown ${ENKLUM_USERNAME}:${ENKLUM_USERNAME} -R /enklum/cmd && chmod 755 -R /enklum/cmd
USER ${ENKLUM_USERNAME}
# TODO --- [END] IN CORE ----


COPY ./features/go /setup/features
RUN bash /enklum/cmd/features.installer.sh
# RUN sudo runuser -u ${ENKLUM_USERNAME} -- bash -ic "/enklum/cmd/features.installer.sh"
# USER ${ENKLUM_USERNAME}