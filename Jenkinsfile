pipeline {
    agent { node { label 'Agent-1' } }
    
    parameters {
        string(name: 'Version', defaultValue: '1.0.1', description: 'Which version to deploy?')


    }

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

    
    
