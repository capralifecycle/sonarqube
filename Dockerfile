FROM sonarqube:6.4-alpine

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
    && curl -O -fSL https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-4.11.0.10660.jar \
    && curl -O -fSL https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-3.1.1.5128.jar \
    && curl -O -fSL https://sonarsource.bintray.com/Distribution/sonar-scm-git-plugin/sonar-scm-git-plugin-1.2.jar \
    && curl -O -fSL https://sonarsource.bintray.com/Distribution/sonar-github-plugin/sonar-github-plugin-1.4.1.822.jar

COPY container/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
