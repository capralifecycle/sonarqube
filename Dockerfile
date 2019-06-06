FROM sonarqube:7.7-community@sha256:4d54c43ba20672582399e0db27e34ac892ee862d4ecbd76dac7f6f5152b83848

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
