FROM sonarqube:7.7-community@sha256:b219c84adc8261f082f0febebd6622f7835f4098d50b038715a99ba4af61770a

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
