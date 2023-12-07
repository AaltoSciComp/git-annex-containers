FROM alpine

RUN \
    #apt-get update && \
    #apt-get install -y wget
    #\
    wget https://downloads.kitenet.net/git-annex/linux/current/git-annex-standalone-amd64.tar.gz && \
    tar xf git-annex-standalone-amd64.tar.gz && \
    rm git-annex-standalone-amd64.tar.gz



FROM alpine
WORKDIR /mnt
COPY --from=0 /git-annex.linux /git-annex.linux
COPY entrypoint.sh /
# $HOME needed because it tries to make a cache there
RUN \
    mkdir -p /mnt && \
    chown 1000 /home && \
    chown 1000 /mnt && \
    chmod a+rx /entrypoint.sh
ENV PATH="/git-annex.linux/:${PATH}"
ENV HOME=/home
USER 1000
#CMD git-annex "$@"
ENTRYPOINT ["/entrypoint.sh"]
