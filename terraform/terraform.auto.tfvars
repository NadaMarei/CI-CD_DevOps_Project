// vpc 
vpc-cidr = "10.0.0.0/16"
vpc-name = "terraform-vpc"

// igw
igw-name = "terraform-internet-gate-way"

// nat 
nat-name = "terrform-nat"

// routing table   
route-table-public-cidr = "0.0.0.0/0"
route-table-public = "terraform-public-route-table" 
route-table-private = "terraform-private-route-table"
    
// subnets
subnet-cidr = ["10.0.0.0/24","10.0.2.0/24"]
subnet-name = ["terraform-public-subnet", "terraform-public-subnet-2"]
availability-zone = ["us-east-1a","us-east-1b"]

subnet-cidr-2 = [ "10.0.1.0/24", "10.0.3.0/24"]
subnet-name-2 = ["terraform-private-subnet", "terraform-private-subnet-2"]
availability-zone-2 = ["us-east-1a","us-east-1b"]

security-group-name ="security-group-ssh-http"