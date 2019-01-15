FROM sonarqube:7.5-community

USER root

RUN set -eux; \
    apt-get update; \
    apt-get install -y \
      jq \
      python3-pip \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    # awscli is used to get credentials from AWS parameter store
    pip3 install awscli; \
    # Add our own extensions
    cd $SONARQUBE_HOME/extensions/plugins; \
    # This plugin is deprecated and replaced by functionality in the paid
    # developer edition. Do we really use this plugin, or can it be removed?
    # And if used, should we invest in the developer edition?
    curl -O -fSL https://binaries.sonarsource.com/Distribution/sonar-github-plugin/sonar-github-plugin-1.4.2.1027.jar

COPY container/entrypoint.sh /entrypoint.sh
USER sonarqube

ENTRYPOINT ["/entrypoint.sh"]
