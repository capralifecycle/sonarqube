FROM sonarqube:7.9-community@sha256:5d4e456eade3157d9c1b2e74e50260965c8e91ce3b634ce55e8dcc11526eade2

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
