def CONTAINER_NAME="jenkins-pipeline"
def CONTAINER_TAG="latest"
def HTTP_PORT="8090"

node {

    stage('Initialize'){
        def dockerHome = tool 'myDocker'
        def mavenHome  = tool 'myMaven'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
    }

    stage('Build'){
        sh "mvn clean install"
    }

    stage('Image Prune'){
        imagePrune(CONTAINER_NAME)
    }

    stage('Image Build'){
        imageBuild(CONTAINER_NAME, CONTAINER_TAG)
    }

    stage('createContainer'){
        createContainer(CONTAINER_NAME, HTTP_PORT)
    }
}

def imagePrune(containerName){
	try{
		sh "docker image prune -f"
		sh "docker stop $containerName"
	}catch(error){}
}

def imageBuild(containerName, tag){
	sh "docker build -t $containterName:$tag"
	echo "Dockerfile build complete."
}

def createContainer(containerName, httpPORT){
	sh "docker run -d -p $httpPORT:$httpPORT --name $containerName"
	echo "Container create complete."
}
