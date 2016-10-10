stage("Build"){
  node("dind") {
    env.DOCKER_API_VERSION="1.22"

    checkout scm

    sh "docker build -t fiveateooate/feckinhaproxy ."
    withDockerRegistry([url:"https://index.docker.io/v1/",credentialsId:"dockerhub_fiveateooate"]) {
      sh "docker push fiveateooate/feckinhaproxy"
    }
  }
}
stage("echo crap") {
  node("dind") {
    sh "env"
  }
}
stage("yourmom") {
  node {
    sh "env"
    sh "echo $BUILD_ID"
  }
}
stage("Test") {
  node {
    sh "echo \"This is a fake test stage\""
    sh "true"
  }
}
stage("Deploy") {
  node {
    def deployment_temp = getKubernetesJson {
       port = 80
       label = 'feckinhaproxy'
       version = newVersion
    }
    kubernetesApply(file: deployment_temp, environment: 'KubeCloud-Local', registry: 'fiveateooate/feckinhaproxy')
  }
}
