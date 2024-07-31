pipeline {
    agent any

    environment {
        GCP_PROJECT = 'infra-svc-sop-mysql'
        GCP_REGION = 'asia-south1'
        SERVICE_ACCOUNT_EMAIL = 'jenkins-impersonate-sa@my-gcp-project.iam.gserviceaccount.com'
        TF_VAR_project = "${GCP_PROJECT}"
        TF_VAR_region = "${GCP_REGION}"
    }

    stages {
        stage('Authenticate to GCP') {
            steps {
                script {
                    // Impersonate the service account
                    sh """
                    gcloud config set auth/impersonate_service_account ${SERVICE_ACCOUNT_EMAIL}
                    """
                }
            }
        }

        stage('Identify Changes') {
            steps {
                script {
                    // Identify changed folders
                    def changes = sh(script: "git diff --name-only HEAD~1", returnStdout: true).trim()
                    def devChanged = changes.contains("dev/")
                    def prodChanged = changes.contains("prod/")
                    
                    if (devChanged) {
                        env.APPLY_DEV = 'true'
                    } else {
                        env.APPLY_DEV = 'false'
                    }
                    
                    if (prodChanged) {
                        env.APPLY_PROD = 'true'
                    } else {
                        env.APPLY_PROD = 'false'
                    }
                    
                    echo "Changes in dev folder: ${env.APPLY_DEV}"
                    echo "Changes in prod folder: ${env.APPLY_PROD}"
                }
            }
        }
        
        stage('Initialize Terraform') {
            steps {
                script {
                    if (env.APPLY_DEV == 'true') {
                        dir('dev') {
                            sh 'terraform init'
                        }
                    }
                    if (env.APPLY_PROD == 'true') {
                        dir('prod') {
                            sh 'terraform init'
                        }
                    }
                }
            }
        }

        stage('Plan Terraform Changes') {
            steps {
                script {
                    if (env.APPLY_DEV == 'true') {
                        dir('dev') {
                            sh 'terraform plan -out=tfplan'
                            def planOutput = sh(script: 'terraform show -json tfplan', returnStdout: true)
                            writeFile file: "tfplan-dev.json", text: planOutput
                            archiveArtifacts artifacts: "tfplan-dev.json"
                        }
                    }
                    if (env.APPLY_PROD == 'true') {
                        dir('prod') {
                            sh 'terraform plan -out=tfplan'
                            def planOutput = sh(script: 'terraform show -json tfplan', returnStdout: true)
                            writeFile file: "tfplan-prod.json", text: planOutput
                            archiveArtifacts artifacts: "tfplan-prod.json"
                        }
                    }
                }
            }
        }

        stage('Request Approval') {
            steps {
                script {
                    emailext (
                        subject: "Approval required for ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                        body: """
                            <p>Please review the Terraform plan and approve or reject the changes.</p>
                            <p><a href="${env.BUILD_URL}console" > Jenkins Build Link</a></p>
                        """,
                        to: 'harsha.kumar@niveussolutions.com'
                    )
                }
            }
        }
        
        stage('Wait for Approval') {
            steps {
                input message: 'Do you approve the Terraform changes?'
            }
        }

        stage('Apply Terraform Changes') {
            steps {
                script {
                    if (env.APPLY_DEV == 'true') {
                        dir('dev') {
                            sh 'terraform apply -auto-approve tfplan'
                        }
                    }
                    if (env.APPLY_PROD == 'true') {
                        dir('prod') {
                            sh 'terraform apply -auto-approve tfplan'
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}