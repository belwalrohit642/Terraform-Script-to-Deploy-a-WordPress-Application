provider "aws" {
  region = "us-east-1" # Change this to your desired region
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
   Name = "MyVPC"
 }
}

# Create Subnet in AZ us-east-1a
resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

# Create Subnet in AZ us-east-1b
resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

#create internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MyInternetGateway"
}
}

# Create Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Associate Route Table with the Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.public.id
}

# Associate Route Table with the Public Subnet
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.public.id
}

# Create Security Group for EC2 instance
resource "aws_security_group" "instance_sg" {
  name_prefix = "instance_sg_"
  vpc_id      = aws_vpc.main.id

  # Inbound rule for SSH and HTTP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule for allowing all traffic to the internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Elastic IP
resource "aws_eip" "ec2_eip" {
  vpc = true
}

# Create EC2 instance
resource "aws_instance" "ec2_instance" {
  # Associate Elastic IP with the EC2 instance
  ami           = "ami-0a0c8eebcdd6dcbd0" # This is an ARM-based Amazon Linux 2 AMI in us-east-1, you may need to update it for other regions
  instance_type = "t4g.micro"
  subnet_id     = aws_subnet.subnet_a.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name = "demo"

}
#associate EIP with EC2 instance
resource "aws_eip_association" "demo-eip-association"{
  instance_id = aws_instance.ec2_instance.id
  allocation_id = aws_eip.ec2_eip.id
}


# Create Security Group for RDS instance
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds_sg_"
  vpc_id      = aws_vpc.main.id
}

# Allow inbound traffic from EC2 instance's security group to RDS instance's security group
resource "aws_security_group_rule" "rds_from_ec2" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.instance_sg.id
}

# Create RDS instance
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "my-rds-subnet-group"
  subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
}

resource "aws_db_instance" "rds_instance" {
  engine            = "mysql"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20
  identifier        = "my-rds-instance"
  username          = "admin"
  password          = "password"
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

output "ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

