#!/bin/bash
set -eu

ssm_get_param() {
  set -o pipefail
  aws ssm get-parameters --region eu-central-1 --names $1 ${2:-} | jq -r .Parameters[0].Value
}

# If running tests, don't bother setting jdbc variables. It will default to embedded H2 database.
if [ "${1:-}" != "test" ]; then
  # Get credentials from parameters store.
  username=$(ssm_get_param /buildtools/sonarqube/jdbc-username)
  password=$(ssm_get_param /buildtools/sonarqube/jdbc-password --with-decryption)
  url=$(ssm_get_param /buildtools/sonarqube/jdbc-url)

  # We cannot use "export xx.xx=xx" having a dot, so we use `env` as a
  # workaround for setting the environment variables.
  exec env \
    sonar.jdbc.username="$username" \
    sonar.jdbc.password="$password" \
    sonar.jdbc.url="$url" \
    "$SONARQUBE_HOME/bin/run.sh"
fi

# Use run script included in SonarQube docker image
exec "$SONARQUBE_HOME/bin/run.sh"
