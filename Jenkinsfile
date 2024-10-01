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


        stage('Initialize'){
            steps{

                sh """
                    cd terraform 
                    ls -lrt
                    terraform init -reconfigure

                
                    """


            }
        }

        stage('Plan'){
            steps{

                sh """
                    cd terraform
                    terraform plan
                    """


            }
        }

        stage('Apply'){
            steps{

                sh """
                    cd terraform 
                    terraform apply -auto-approve
                    """


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

    
    
