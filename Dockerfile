FROM alpine:3.3
RUN wget -O- "http://s3.amazonaws.com/babl/babl-server_linux_amd64.gz" | gunzip > /bin/babl-server && chmod +x /bin/babl-server
RUN wget -O- "http://s3.amazonaws.com/babl/babl_linux_amd64.gz" | gunzip > /bin/babl && chmod +x /bin/babl
ADD ssh /root/.ssh
RUN \
  apk add --no-cache git openssh-client && \
  git config --global user.email "bot@babl.sh" && \
  git config --global user.name "Babl" && \
  chmod 0600 /root/.ssh/*

ADD app start /bin/
RUN chmod +x /bin/app /bin/start
CMD ["babl-server"]
