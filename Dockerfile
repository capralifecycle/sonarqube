FROM sonarqube:7.1-alpine

RUN apk add -Uuv \
      curl \
      jq \
      py2-pip \
    \
    # awscli is used to get credentials from AWS parameter store
    && pip install awscli \
    \
    # Add our own extensions
    && cd $SONARQUBE_HOME/extensions/plugins \
    && curl -O -fSL https://binaries.sonarsource.com/Distribution/sonar-java-plugin/sonar-java-plugin-5.4.0.14284.jar \
    && curl -O -fSL https://binaries.sonarsource.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-4.1.0.6085.jar \
    && curl -O -fSL https://binaries.sonarsource.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-1.4.1.1128.jar \
    && curl -O -fSL https://binaries.sonarsource.com/Distribution/sonar-github-plugin/sonar-github-plugin-1.4.2.1027.jar

COPY container/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
