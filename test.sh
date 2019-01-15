#!/bin/bash
set -eu

docker build -t sonarqube-test .

./test-image.sh sonarqube-test
