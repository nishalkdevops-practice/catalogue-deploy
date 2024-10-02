pipeline {
    agent { node { label 'Agent-1' } }

    options {
        ansiColor('xterm')
    }
    
    parameters {
        string(name: 'version', defaultValue: '1.0.9', description: 'Which version to deploy?')


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
                    terraform plan -var="app_version=${params.version}"
                    """


            }
        }

        stage('Approval') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
                submitter "Nishal"
                parameters {
                    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                }
            }
        
            steps {
                echo "Hello, ${PERSON}, nice to meet you."
            }
        }

        stage('Apply'){
            steps{

                sh """
                    cd terraform 
                    terraform apply -var="app_version=${params.version}" -auto-approve
                    """


            }
        }

        // stage('Destroy'){
        //     steps{

        //         sh """
        //             cd terraform 
        //             terraform destroy -auto-approve
        //             """


        //     }
        // }




    }

    post{
        always{
            echo 'cleaning up workspace'
            deleteDir()
        }
    }
}

    
    
