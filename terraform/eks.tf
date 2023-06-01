#create role for eks

resource "aws_iam_role" "eks-iam-role" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
#Attach policy
resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-role.name
}


  
  
resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-iam-role.name
}


#create cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = "eks-cluster"
  role_arn = aws_iam_role.eks-iam-role.arn

  vpc_config {
    subnet_ids = [
     aws_subnet.subnets-private[0].id,
     aws_subnet.subnets-private[1].id, 
     aws_subnet.subnets-public[0].id,
     aws_subnet.subnets-public[1].id

    ]
    endpoint_private_access = true
    endpoint_public_access  = true 
  }

  
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    # aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
    # aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly-EKS,
  ]
}






resource "aws_eks_addon" "kubeproxy-addon" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name = "kube-proxy"
}

resource "aws_eks_addon" "coredns-addon" {
  cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name = "coredns"

}

resource "aws_eks_addon" "vpc-cni-addon" {
 cluster_name = aws_eks_cluster.eks-cluster.name
  addon_name = "vpc-cni"
}


// aws eks --region us-east-1 update-kubeconfig --name eks-cluster
// kubectl get svc 