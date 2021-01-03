def CONTAINER_NAME="jenkins-pipeline"
def CONTAINER_TAG="latest"
def HTTP_PORT="8090"

node {

    stage('Initialize'){
        def dockerHome = tool 'myDocker'
        def mavenHome  = tool 'myMaven'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
    }

    stage('Image Prune'){
        imagePrune(CONTAINER_NAME)
    }

    stage('Image Build'){
        imageBuild(CONTAINER_NAME, CONTAINER_TAG)
    }

    stage('Run'){
        runApp(CONTAINER_NAME, HTTP_PORT)
    }
}

def imagePrune(containerName){
	try{
		sh "sudo docker image prune -f"
		sh "sudo docker container stop $containerName"
	}catch(error){}
}

def imageBuild(containerName, tag){
	sh "sudo docker build -t $containerName:$tag ."
	echo "Dockerfile build complete."
}

def runApp(containerName, httpPORT){
	sh "sudo docker run -d -p $httpPORT:$httpPORT $containerName"
    echo "Container create complete."
}

