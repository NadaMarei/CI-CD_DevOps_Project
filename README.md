# ITI-DevOps-Project

# Project Description :

A Full CI/CD Project to build Nodejs Backend app on EKS cluster using Terraform IAC and Jenkins


# Step 1: RUN The IAC 
```
- Terraform init 
- Terraform  plan
- Terraform  apply

```
# Step 2:connect to the jump host 

1) ssh into the private worker node 
   ```
   ssh -i "dev.pem" ec2-user@10.0.1.14
   ```
2) Install docker using the following commands
   ```
   sudo yum update -y
   sudo yum info docker
   sudo yum install docker
   sudo service docker start
   sudo systemctl enable docker.service
   ```
3) Install kubectl and aws cli packages on jump host 

4) Configure aws on jump host
   ```
   aws configure
   ```
5) Connect on EKS cluster
   ```
   aws eks --region us-east-1 update-kubeconfig --name eks-cluster
   kubectl get svc 
   ```
6) clone the rebo and apply the yaml files 

# Step 3 Enter to jenkins through public ip :8080
  http://aa395be7ae9fe4cd4a88c630601f3f8e-1798624989.us-east-1.elb.amazonaws.com:8080/
   
   1) install plugins and create account 
   2) create credentials for dockerhub
   3) create new item -->Piepline and build CI CD through jenkinsfile
   

     
   4) Run your app Through 
   
      http://aba13c6c7792a49e3800af58c9e4f5da-fd5057378e457d9b.elb.us-east-1.amazonaws.com :80
      
      











