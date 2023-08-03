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
`mysql -h aws-rds-endpoint -u admin -p`<br>   
Here replace `aws-rds-endpoint` with your AWS RDS Endpoint<br>
<br>
Once you connect to a MySQL server create a database `wordpress`. And `exit` from the MySQL server <br> 
<br>
![5](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/f2cf8320-88de-4860-acd4-846f40e91fe4)

Now Create a script that will install the docker on the Ec2 instance and start the docker service and pull the  WordPress official  image from the docker hub and runs a Docker container in the background (-d) with port mapping (-P) and It sets environment variables (-e) for a WordPress container to connect to a MySQL database hosted on the specified RDS instance. The environment variables define the database host, username, password, and database name.<br>
<br>
This Script you can find in  my repository.<br>
<br>
Give Execution Permission to the script and execute the script on Ec2.<br>

![6](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/169b6cd9-1cd3-40c7-ab7f-fdb9fa7c1ed1)

Once the execution part of the script  is done you can check the running docker container by using the below command:<br>
`sudo docker ps`<br>
<br>

One important step to do to access the WordPress website, you have to edit the inbound rules(Inbound rules control the incoming traffic that's allowed to reach the instance). Add an inbound rule of type custom TCP for a port range of '32768' for source MYIPaddress (mention your port number in which WordPress is listening) you will get this port number from the 'docker ps command.<br><br>
![7 1](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/35343731-fb63-4e7e-97ad-64ca68a5cbe0)
<br>
<br>
Now access WordPress using `http://elastic-ip-address:32768`. And set up the WordPress login page and finally you get the WordPress dashboard.<br>
<br>
![9](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/ce2c6933-ffcd-40ff-9a6d-d1f0f2098ddd)
<br>

Now Add phpmyadmin in deployment on the same instance, so that one can access Database. Run the docker container of `phpmyadmin` in the background (-d) with port mapping (-P). And for this also you have to edit the inbound rules as we have done for WordPress. <br>
<br>
![10](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/05d9a907-1154-402a-9126-727e41ebea84)
<br>

To access phpmyadmin page used this URL  `http://elastic-ipaddress:8080`. And fill the login page with the URL of the AWS RDS endpoint, with username and with password<br>
<br>
![11](https://github.com/belwalrohit642/Terraform-Script-to-Deploy-a-WordPress-Application/assets/96739082/0a531ca3-7d35-41a9-ba13-92a867a165a9)<br>



