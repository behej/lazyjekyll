pipeline {
  agent {
    docker {
      image 'jekyll:1.0'
    }

  }
  stages {
    stage('build') {
      steps {
        sh 'bundle exec jekyll build'
      }
    }

    stage('deploy') {
      when {
        branch 'master'  //only run these steps on the master branch
      }

      steps {
        ftpPublisher alwaysPublishFromMaster: false,
            masterNodeName: '',
            paramPublish: null,
            continueOnError: false,
            failOnError: true,
            publishers: [[configName: 'Lazyjekyll', transfers: [[asciiMode: false, cleanRemote: false, excludes: '', flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: 'jekyll', remoteDirectorySDF: false, removePrefix: '_site', sourceFiles: '_site/**']], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true]]
      }
    }
  }
}