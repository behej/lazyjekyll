pipeline {
  agent {
    docker {
      image 'jekyll:1.1'
      args '-v /etc/passwd:/etc/passwd:ro -u root'
    }

  }
  stages {

    stage('Who am I') {
      steps {
        sh 'whoami'
      }
    }

    stage('ls') {
      steps {
        sh 'ls -al /usr/bin/'
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
        sh 'jekyll -v'
      }
    }

    stage('Path') {
      steps {
        sh 'echo $PATH'
      }
    }

  }
}
