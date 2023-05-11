pipeline {
  agent {
    docker {
      image 'jekyll:1.2'
    }

  }
  stages {
    stage('all') {
      parallel {
        stage('gems') {
          steps {
            sh 'gem list'
          }
        }

        stage('ls') {
          steps {
            sh 'ls -al /usr/bin/'
            sh 'ls -al'
          }
        }

        stage('pwd') {
          steps {
            sh 'pwd'
          }
        }

        stage('Versions') {
          steps {
            sh 'bundle -v'
            sh '/usr/bin/jekyll -v'
          }
        }

        stage('Path') {
          steps {
            sh 'echo $PATH'
          }
        }

        stage('build') {
          steps {
            sh 'bundle exec jekyll build'
            stash(name: 'Generated HTML', includes: '_site/**')
            ftpPublisher continueOnError: false,
                 failOnError: true,
                 publishers: [[configName: 'Lazyjekyll', transfers: [[asciiMode: false, cleanRemote: false, excludes: '', flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: 'jekyll', remoteDirectorySDF: false, removePrefix: '_site', sourceFiles: '_site/**']], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: true]]
            archiveArtifacts '_site/**'
          }
        }

      }
    }

  }
}