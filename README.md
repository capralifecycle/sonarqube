# SonarQube

[![Build Status](https://jenkins.capra.tv/buildStatus/icon?job=buildtools/sonarqube/master)](https://jenkins.capra.tv/job/buildtools/job/sonarqube/job/master/)

This Docker image build on the library image of SonarQube and
polls database configuration from AWS parameters store when running.

Details about our setup is available on https://confluence.capraconsulting.no/x/UoYCBQ

## Testing the build

To test the build locally:

```bash
./test.sh
```

## Auto-deployment

This setup currently auto-deploys all builds on master to ECS directly
from Jenkins. This is planned to be replaced with
https://confluence.capraconsulting.no/display/CALS/SNS+Based+ECS+deploy+Semantic+Versioning

Also note that deployments (at least between explicit versions) might require
a database migration triggered from https://sonarqube.capra.tv/setup before
the service is operational again.
