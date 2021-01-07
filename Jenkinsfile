def CONTAINER_NAME="jenkins-pipeline"
def CONTAINER_TAG="latest"
def DOCKER_HUB_USER="ismailsimsekdev"
def GIT_LİNK="https://github.com/simsekismail/maven-dockerfile.git"
def HTTP_PORT="8090"

node {

    stage('Initialize'){
        def dockerHome = tool 'myDocker'
        def mavenHome  = tool 'myMaven'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
    }

    stage('Git Clone'){
        gitClone(GIT_LİNK)
    }

    stage('Image Prune'){
        imagePrune(CONTAINER_NAME)
    }

    stage('Image Build'){
        imageBuild(CONTAINER_NAME, CONTAINER_TAG)
    }

    stage('Push to Docker Registry'){
        withCredentials([usernamePassword(credentialsId: 'dockerHubAccount', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            pushToImage(CONTAINER_NAME, CONTAINER_TAG, USERNAME, PASSWORD)
        }
    }

    stage('Run'){
        runApp(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, HTTP_PORT)
    }
}

def gitClone(gitLink)
{
    sh "sudo rm -rf maven-dockerfile"
    sh "sudo git clone $gitLink"
}

def imagePrune(containerName){
	try{
		sh "sudo docker image prune -f"
		sh "sudo docker container rm -f $containerName"
	}catch(error){}
}

def imageBuild(containerName, tag){
	sh "sudo docker build -t $containerName:$tag /home/ismailsimsekdev/maven-dockerfile"
	echo "Dockerfile build complete."
}

def pushToImage(containerName, tag, dockerUser, dockerPassword){
    sh "sudo docker login -u $dockerUser -p $dockerPassword"
    sh "sudo docker tag $containerName:$tag $dockerUser/$containerName:$tag"
    sh "sudo docker push $dockerUser/$containerName:$tag"
    echo "Image push complete"
}

def runApp(containerName, tag, dockerHubUser, httpPORT){
    sh "sudo docker pull $dockerHubUser/$containerName"
    sh "sudo gcloud container clusters get-credentials cluster-1 --zone europe-west3-c --project constant-setup-300113"
	sh "sudo kubectl apply -f deployment.yaml"
    echo "Container create complete."
}

