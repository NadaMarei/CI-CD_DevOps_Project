#create worker node
resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}


#Grant access to EC2 

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

# allow to download and run docker images from gcr repository 
resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

#create worker node
resource "aws_eks_node_group" "node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = [aws_subnet.subnets-private[0].id,aws_subnet.subnets-private[1].id,] 

  capacity_type = "ON_DEMAND"
  instance_types = ["t3.medium"]
  
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
  remote_access {
    ec2_ssh_key = "dev"
  }

 
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}
#cat ~/.aws/credentials

# sudo yum update -y
# sudo yum info docker
# sudo yum install docker
# sudo service docker start
# sudo systemctl enable docker.service

# sudo apt-get install zip
# sudo apt-get install unzip
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# curl -LO https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl
# curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
# echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# chmod +x kubectl
# mkdir -p ~/.local/bin
# mv ./kubectl ~/.local/bin/kubectl
# kubectl version --client --output=yaml  
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install
# sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# unzip -u awscliv2.zip
# sudo ./aws/install
# ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
# sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
# which aws
# ls -l /usr/local/bin/aws
# aws eks --region us-east-1 update-kubeconfig --name eks-cluster
# alias k="kubectl"