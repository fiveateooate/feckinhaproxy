node("dind") {
  deleteDir()
  env.DOCKER_API_VERSION="1.22"
  env.PROJECT_NAME="feckinhaproxy"
  
  stage("Checkout") {
    checkout scm
  }
  stage("Build") {
    sh '''
    DOCKER_TAG=`cat .version`.${BUILD_ID}
    docker build -t fiveateooate/${PROJECT_NAME}:${DOCKER_TAG} ./kibana
    '''
  }
  stage("Push") {
    withDockerRegistry([url:"https://index.docker.io/v1/",credentialsId:"dockerhub_fiveateooate"]) {
      sh'''
      DOCKER_TAG=`cat .version`.${BUILD_ID}
      docker push fiveateooate/${PROJECT_NAME}:${DOCKER_TAG}
      '''
    }
  }
}

node("kube-deployer") {
  stage "Checkout"
  checkout scm

  stage "Deploy"  
  sh '''
  DOCKER_TAG=`cat .version`.${BUILD_ID}
  for file in kubernetes/*.yaml; do
    cat $file | sed "s/JENKINS_DOCKER_TAG/$DOCKER_TAG/g" | kubectl apply -f -
  done

  '''
}
