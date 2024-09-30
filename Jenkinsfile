pipeline {
    agent { node { label 'Agent-1' } }

    stages {
        stage('Deploy'){
            steps{

                echo "deploying for now......"
              }
            }
    }

    post{
        always{
            echo 'cleaning up workspace'
            deleteDir()
        }
    }
}

    
    
