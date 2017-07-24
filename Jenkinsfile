#!/usr/bin/env groovy

// See https://github.com/capralifecycle/jenkins-pipeline-library
@Library('cals') _

properties([
  pipelineTriggers([
    // Build a new version every night so we keep up to date with upstream changes
    cron('H H(2-6) * * *'),

    // Build when pushing to repo
    githubPush(),
  ]),

  // "GitHub project"
  [
    $class: 'GithubProjectProperty',
    displayName: '',
    projectUrlStr: 'https://github.com/capralifecycle/sonarqube-docker/'
  ],
])

dockerNode {
  stage('Checkout source') {
    checkout scm
  }

  def img

  stage('Build Docker image') {
    img = docker.build('sonarqube', '--pull .')
  }

  if (env.BRANCH_NAME == 'master') {
    stage('Push Docker image') {
      def tagName = sh([
        returnStdout: true,
        script: 'date +%Y%m%d-%H%M'
      ]).trim() + '-' + env.BUILD_NUMBER

      img.push(tagName)
      img.push('latest')
    }
  }
}
