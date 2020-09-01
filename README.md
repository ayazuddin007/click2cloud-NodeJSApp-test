Node JS Application Using Devops CI-CD Pipleine
------------------------------------------------

Pre-requisite
-----------------
  - Git
  - Jenkins
  - Ansible
  - Docker
  - Kubernetes 
  - AWS Cloud
 
 Directory-Structure Understanding
 -------------------------------------
  - server.js and package.json are the Node-js Application Files.Whatever we want to change as input ,we can do that in server.js and package.json is the dependency for server.js file.
  - hosts file is Ansible host inventory file.
  - Jenkinsfile is DSL pipeline file,which contains all pipeline stages.
  - Dockerfile is used for bulding nodejs image.
  - kubernetes directory contains kubernets deployment and service  yaml files (i.e  click2cloud-deploy.yml and click2cloud-service.yml)
  - playbooks directory contains all ansible playbook for docker and kubernetes. (i.e docker-container.yml,docker-image.yml,kubernetes-click2cloud-deployment.yml,kubernetes-click2cloud-service.yml,kubernetes-click2cloud-podscaling.yml and kubernetes-click2cloud-service.yml) 
  - jmeter-test directory contains all Load test files and performance test files.
  - results directory contains all the result of ci-cd pipeline in the form of image.
  
  Continuous Integration Tools
  -----------------------------
  Git, Jenkins
  
  Continuous Deployment Tools
  ----------------------------
  Ansible,Docker,Kubernetes
  
  CI-CD Pipline Stages
  ---------------------
  In the Jenkinsfile, it is divided into 4 stages.
     1) Declarative Checkout SCM
     2) Copy NodeJS App file to Ansible
     3) Push Docker Image to Docker Hub
     4) Deploy to kubernetes cluster
     
  1)Declarative Checkout SCM
  ---------------------------
   - when a devloper commits the Node JS Application code in SCM (Git & Github),then jenkins get triggered by pollscm option enabled in the job.It pull the code form github and store it into the jenkins job work space.
  
  2)Copy NodeJS App file to Ansible
  ---------------------------------
   - Jenkins copies the node js application files to Ansible.Ansible is acting as Configuration Manager and deployer.Ansible has all nodes (Docker and kubernetes) in its inventory file (hosts file). It also has the Docker file.Ansible has the all playbooks and kubernets yaml files.
   - Ansible playbook files:  docker-container.yml,docker-image.yml,kubernetes-click2cloud-deployment.yml,kubernetes-click2cloud-service.yml,kubernetes-click2cloud-podscaling.yml and kubernetes-click2cloud-service.yml
   - kubernets files: click2cloud-deploy.yml and click2cloud-service.yml
                     
  3)Push Docker Image to Docker Hub
  --------------------------------
  - Ansible executes the docker-image.yml files,it has the task to build the dockerfile which will create the node-js images , tag it and upload it to the dockerhub(i.e ayazway)
  - Dockerfile, Node js will expose the port to 3000.
  
  
  4)Deploy to kubernetes cluster
  -----------------------------
  - Ansible excutes the kubernetes-click2cloud-deployment.yml and kubernetes-click2cloud-service.yml files. 
  - While executing kubernetes-click2cloud-deployment.yml file on Ansible, the k8s deployment file (i.e click2cloud-deploy.yml) will be get copied into the K8s and pull the nodejs-test image from docker hub create the pods and expose the port on 3000.
  - While executing kubernetes-click2cloud-service.yml file on Ansible,it will copy the k8s service file (i.e click2cloud-service.yml) on kubernetes and create the service and expose the service on port 31200.
  
  
  Jmeter Test
  -------------
  - We have Done the Jmeter Load test and performance test ,whose files are available in jmeter directory for reference. 
  
  Kubernetes Deployment File (click2cloud-deploy.yml) 
  -------------------------------------------------------
  - it will first creat 10 pods,when there is a code update it will suddenly roll out to 7, then to 10.Minimum 7 pod will be running.
  - it will expose the port to 3000.
  - if cpu and memory utilization is above 50%,then it will perform scaling.
  
  Kubernetes Service File (click2cloud-service.yml)
  -------------------------------------------------------
  - it will create the service of type load balancer and expose the service oustside world by 31200 port.
  - to check the output : http:// K8s-Master-IP:31200.
  
  




