pipeline {
    agent { node { label 'Agent-1' } }
    
    parameters {
        string(name: 'version', defaultValue: '1.0.1', description: 'Which version to deploy?')


    }

    stages {
        stage('Deploy'){
            steps{

                echo "deploying for now......"
                echo "version from params: ${params.version}"
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

    
    
