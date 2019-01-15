#!/bin/sh
set -eu

ssm_get_param() {
  aws ssm get-parameters --region eu-central-1 --names $1 ${2:-} | jq -r .Parameters[0].Value
}

# If running tests, don't bother setting jdbc variables. It will default to embedded H2 database.
if [ "${1:-}" != "test" ]; then
  # Get credentials from parameters store
  export sonar.jdbc.username=$(ssm_get_param /buildtools/sonarqube/jdbc-username)
  export sonar.jdbc.password=$(ssm_get_param /buildtools/sonarqube/jdbc-password --with-decryption)
  export sonar.jdbc.url=$(ssm_get_param /buildtools/sonarqube/jdbc-url)
fi

# Use run script included in SonarQube docker image
exec "$SONARQUBE_HOME/bin/run.sh"
