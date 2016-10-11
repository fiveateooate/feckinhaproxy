// docker build/push step
stage("Build"){
  node("dind") {
    withDockerRegistry([url:"https://index.docker.io/v1/",credentialsId:"dockerhub_fiveateooate"]) {
      env.DOCKER_API_VERSION="1.22"
      env.PROJECT_NAME="feckinhaproxy"

      checkout scm

      sh '''
        set -e

        VERSION=`cat .version`".${BUILD_ID}"
        echo "version=${VERSION}"
        docker build -t fiveateooate/${PROJECT_NAME}:${VERSION} .
        docker push fiveateooate/${PROJECT_NAME}:${VERSION}
      '''
    }
  }
}

// run some tests in here
stage("Test") {
  node {
    sh '''
      set -e

      echo "This is a fake test stage"
      true
    '''
  }
}

// This stage uses kubectl to submit the service jsons
stage("Deploy") {
  node('kube-deployer') {
   checkout scm

    sh '''
      set -e

      VERSION=`cat .version`".${BUILD_ID}"
      for file in kubernetes/*.json; do
        cat $file | sed "s/JENKINS_BUILD_ID/$VERSION/g" | kubectl apply -f -
      done
    '''
  }
}
