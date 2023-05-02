pipeline {
  agent {
    docker {
      image 'jekyll:1.1'
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
