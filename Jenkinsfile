def ansibleServerIP = '172.31.7.186'
def pushDockerImage = 'ansible-playbook -i hosts playbooks/docker-image.yml'
def createK8SDeployment = 'ansible-playbook -i hosts playbooks/kubernetes-click2cloud-deployment.yml'
def createK8Service = 'ansible-playbook -i hosts playbooks/kubernetes-click2cloud-service.yml'

pipeline {
    agent any

    stages {
        //stage("Git Clone") {
           // steps {
            //    git branch: 'master', credentialsId: 'gitCredentials', url: 'https://github.com/ayazuddin007/NodeJSApp.git'
            //}
        //}
        stage("Copy NodeJSApp Files to Ansible") {
            steps {
                sshagent(['ansibleCredentials']) {
                    // Copy war file to Ansible Server
                    sh "scp -o StrictHostKeyChecking=no * ec2-user@${ansibleServerIP}:/home/ec2-user/"
                }
            }
        }
        stage("Push Docker Image to Docker Hub") {
            steps {
                sshagent(['ansibleCredentials']) {
                    // Push Docker Image to Docker Hub by Runnning docker-image.yml on Ansible Server
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@${ansibleServerIP} ${pushDockerImage}"
                }
            }
        }
        stage('Deploy to Kubernetes Cluster') {
            steps {
                sshagent(['ansibleCredentials']) {
                    // Create click2cloud-deployment on K8S Server by running kubernetes-click2cloud-deployment.yml on Ansible Server
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@${ansibleServerIP} ${createK8SDeployment}"
                    // Create click2cloud-service on K8S Server by running kubernetes-click2cloud-service.yml on Ansible Server
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@${ansibleServerIP} ${createK8Service}"     
                }
            }
        }
    }
}
