pipeline {
    agent { node { label 'Agent-1' } }

    options {
        ansiColor('xterm')
    }
    
    parameters {
        string(name: 'version', defaultValue: '1.0.9', description: 'Which version to deploy?')
        string(name: 'environment', defaultValue: 'dev', description: 'Which environment to deploy?')


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
                    terraform init -backend-config=${params.environment}/backend.tf -reconfigure

                
                    """


            }
        }

        stage('Plan'){
            steps{

                sh """
                    cd terraform
                    terraform plan -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -var="env=${params.environment}"
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
                    terraform apply -var-file=${params.environment}/${params.environment}.tfvars -var="app_version=${params.version}" -var="env=${params.environment}" -auto-approve
                    """


            }
        }

        // stage('Destroy'){
        //     steps{

        //         sh """
        //             cd terraform 
        //             terraform destroy -var="app_version=${params.version}" -auto-approve
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

    
    
