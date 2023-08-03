# Terraform-Script-to-Deploy-a-WordPress-Application

This Terraform script sets up an AWS infrastructure that includes a Virtual Private Cloud (VPC), public subnets, an  internet gateway, security groups, an EC2 instance, and an RDS instance. The EC2 instance is accessible via HTTP, and the RDS instance runs a MySQL database. The script also sets up routing, allows communication between instances using security groups, and assigns Elastic IPs to the EC2 instance. 


Firstly Clone this repository on your locally
git clone https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application.git

After cloning the repository go inside the Repo folder and execute the `terraform init` command which initializes the working directory and sets up the necessary components for Terraform to manage the AWS resources defined in the script. 
Terraform init command does several tasks such as Backend configuration, plugin installation, module installation, provider Initialization, and State Configuration.

Once the initialization is complete, execute the `terraform plan` which  examines the configuration and the current state of the infrastructure and generates an execution plan to show what actions Terraform will take to reach the desired state defined in the script. The terraform plan command is a dry run.

Finally, execute the `terraform  apply` command which  is used to apply the changes and provisions to the AWS resources defined in the configuration.

After using `terraform apply`, you can double-check on your AWS Management Console to see what resources Terraform provisioned on AWS.

![1](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/bab1405e-9a17-4ed5-992f-988d71834866)
