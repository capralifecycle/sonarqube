#!/bin/sh

# Log in to AWS using task role that gives permission
eval $(aws ecr get-login --no-include-email --region eu-central-1)

# Get credentials from parameters store
export SONARQUBE_JDBC_USERNAME=$(aws ssm get-parameters --region eu-central-1 --names /buildtools/sonarqube/jdbc-username | jq -r .Parameters[0].Value)
export SONARQUBE_JDBC_PASSWORD=$(aws ssm get-parameters --region eu-central-1 --names /buildtools/sonarqube/jdbc-password --with-decryption | jq -r .Parameters[0].Value)
export SONARQUBE_JDBC_URL=$(aws ssm get-parameters --region eu-central-1 --names /buildtools/sonarqube/jdbc-url | jq -r .Parameters[0].Value)

# Use run script included in SonarQube docker image
exec "$SONARQUBE_HOME/bin/run.sh"
