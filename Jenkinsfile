#!/usr/bin/env groovy

// See https://github.com/capralifecycle/jenkins-pipeline-library
@Library('cals') _

def dockerImageName = '923402097046.dkr.ecr.eu-central-1.amazonaws.com/buildtools/service/sonarqube'

buildConfig([
  jobProperties: [
    pipelineTriggers([
      // Build a new version every night so we keep up to date with upstream changes
      cron('H H(2-6) * * *'),
    ]),
  ],
  slack: [
    channel: '#cals-dev-info',
    teamDomain: 'cals-capra',
  ],
]) {
  dockerNode {
    stage('Checkout source') {
      checkout scm
    }

    def img
    def lastImageId = dockerPullCacheImage(dockerImageName)

    stage('Build Docker image') {
      img = docker.build(dockerImageName, "--cache-from $lastImageId --pull .")
    }

    stage('Test build') {
      docker.image('docker').inside {
        sh "./test-image.sh ${img.id}"
      }
    }

    def isSameImage = dockerPushCacheImage(img, lastImageId)

    if (env.BRANCH_NAME == 'master' && !isSameImage) {
      def tagName = sh([
        returnStdout: true,
        script: 'date +%Y%m%d-%H%M'
      ]).trim() + '-' + env.BUILD_NUMBER

      stage('Push Docker image') {
        img.push(tagName)
        img.push('latest')
      }

      stage('Deploy to ECS') {
        def image = "$dockerImageName:$tagName"
        ecsDeploy("--aws-instance-profile -r eu-central-1 -c buildtools-stable -n sonarqube -i $image --timeout 300")
        slackNotify message: "Deploying new build of Sonarqube to ECS"
      }
    }
  }
}
