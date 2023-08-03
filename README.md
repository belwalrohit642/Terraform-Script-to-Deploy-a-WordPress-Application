# Terraform-Script-to-Deploy-a-WordPress-Application

This Terraform script sets up an AWS infrastructure that includes a Virtual Private Cloud (VPC), public subnets, an  internet gateway, security groups, an EC2 instance, and an RDS instance. The EC2 instance is accessible via HTTP, and the RDS instance runs a MySQL database. The script also sets up routing, allows communication between instances using security groups, and assigns Elastic IPs to the EC2 instance. 


Firstly Clone this repository on your locally
git clone https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application.git

After cloning the repository go inside the Repo folder and execute the `terraform init` command which initializes the working directory and sets up the necessary components for Terraform to manage the AWS resources defined in the script. <br>
<br>
Terraform init command does several tasks such as Backend configuration, plugin installation, module installation, provider Initialization, and State Configuration.<br>
<br>
![1](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/bab1405e-9a17-4ed5-992f-988d71834866)


Once the initialization is complete, execute the `terraform plan` which  examines the configuration and the current state of the infrastructure and generates an execution plan to show what actions Terraform will take to reach the desired state defined in the script. The terraform plan command is a dry run.

![2](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/1c89adcf-004b-48b5-959a-3b0180ceb48e)


Finally, execute the `terraform  apply` command which  is used to apply the changes and provisions to the AWS resources defined in the configuration.

![3](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/ee2b740a-364b-4a3e-a7ad-de49dff4936e)


After using `terraform apply`, you can double-check on your AWS Management Console to see what resources Terraform provisioned on AWS.

In the terraform script, the EC2 instance is launched with a specific key_name set to "demo". During the EC2 instance creation, an AWS key pair with the name "demo" is associated with the instance.<br>
<br>
To SSH connection to your EC2 instance using the below command: <br>
`ssh -i /path/to/demo.pem ec2-user@public_ip_of_ec2_instance`<br>
<br>
![4](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/03fd055f-65a9-4053-88b7-feb7b40fed03)
<br>

To connect with the AWS RDS first, we have to install the `MySQL client` on the instance using the below command: <br>
`sudo apt install mysql-client` <br>

Once installation is completed used the below command to connect to a MySQL server hosted at the specified RDS (Amazon Relational Database Service) endpoint.<br>
`mysql -h <aws-rds-endpoint> -u admin -p<br>
<br>
![5](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/f2cf8320-88de-4860-acd4-846f40e91fe4)



