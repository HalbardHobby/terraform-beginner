# Terraform Beginner

This is a simple terraform exercise.

## AWS deployment

For AWS, secrets are provided via environment variables to avoid revealing keys.

### Deployed components

The dployed components are:

#### VPC
VPC deploys a main vpc, along with subnets, and security groups to organize the infrastructure.

![vpc](./media/vpc.png "VPC")

#### EC2
A public server is deployed in a subnet with internet access, and a security group allows for these to be the only component that can access the database.

![ec2](./media/ec2.png "EC2")

##### Public Subnet
Public subnet for internet access

![subnet](./media/public_subnet.png "subnet")

##### Security Group
this security group allows for access from the internet.

![security group](./media/server_group.png "security group")


#### RDS
A simple postgres database is deployed, using a subnets and security groups to avoid ingress from the internet.

![db](./media/db.png "DB")

##### Private Subnets
Private subnets for the database.

![subnet](./media/subnet_0.png "subnet")
![subnet](./media/Subnet_1.png "subnet")

##### Security Group
This security group, and its security rule allow for secure access

![security group](./media/db_group.png "security group")

###### Security Group Rule
This rule allows for access only from the server group

![security group](./media/inbound_rule.png "security group")
