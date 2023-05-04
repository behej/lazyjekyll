pipeline {
  agent {
    docker {
      image 'jekyll:1.1'
      args '-u root:root'
    }

  }
  stages {
    stage('all') {
      parallel {
        stage('Who am I') {
          steps {
            sh 'whoami'
          }
        }

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
            sh 'cd ~'
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
          }
        }
      }
    }
  }
}
