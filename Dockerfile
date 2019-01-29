FROM sonarqube:7.6-community@sha256:13cebaf9423a85995fb31c0f566677a1faa7d035346ce5496e789561c6e7f174

USER root

RUN set -eux; \
    apt-get update; \
    apt-get install -y \
      jq \
      python3-pip \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    # awscli is used to get credentials from AWS parameter store
    pip3 install awscli

COPY container/entrypoint.sh /entrypoint.sh
USER sonarqube

ENTRYPOINT ["/entrypoint.sh"]
