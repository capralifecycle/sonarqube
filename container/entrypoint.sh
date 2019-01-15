#!/bin/sh

# Get credentials from parameters store
export sonar.jdbc.username==$(aws ssm get-parameters --region eu-central-1 --names /buildtools/sonarqube/jdbc-username | jq -r .Parameters[0].Value)
export sonar.jdbc.password==$(aws ssm get-parameters --region eu-central-1 --names /buildtools/sonarqube/jdbc-password --with-decryption | jq -r .Parameters[0].Value)
export sonar.jdbc.url==$(aws ssm get-parameters --region eu-central-1 --names /buildtools/sonarqube/jdbc-url | jq -r .Parameters[0].Value)

# Use run script included in SonarQube docker image
exec "$SONARQUBE_HOME/bin/run.sh"
