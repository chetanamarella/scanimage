pipeline {
  environment {
    registry = "chetana3/scan"
    registryCredential = 'dockerhub'
    dockerImage = ''
    
  }
  agent none
  stages {
    stage('Cloning Git') {
      agent {label 'master'}
      steps {
        git 'https://github.com/chetanamarella/scanimage.git'
      }
    }
    stage('Building image') {
      agent {label 'master'}
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Pushing Image') {
      agent {label 'master'}
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Scan Image') {
      agent {label 'master'}
      steps{
        script {
          sh 'echo "docker.io/chetana3/scan /home/ubuntu/docker/Dockerfile" > anchore_images'
          anchore name: 'anchore_images' 
        }
      }
    }
    stage('Removing container if it already exists') {
      agent {label 'master'}
      steps{
        sh '''#!/bin/bash
                x=$( docker container inspect -f '{{.State.Status}}' scanContainer )
                echo $x
                if [ $x == "running" ]
                then
                        sudo docker stop scanContainer
                        sudo docker rm scanContainer
                elif [ $x == "exited" ]
                then
                        sudo docker rm scanContainer
                        
                else
                        echo "Container does not exist"
                fi
                
                '''
          
       
      }
    }

    
    stage('Deploying to test server') {
      agent {label 'master'}
      steps{
        script {
          dockerImage.run('-itd --name scanContainer -p 8087:80')
          
        }
      }
    }
  }
}
