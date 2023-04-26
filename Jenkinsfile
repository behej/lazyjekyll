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

  }
}
