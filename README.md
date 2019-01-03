AWS Umbraco POC environment 

Create an umbraco_poc.pem key
Update the provider.tf with your own VPC credentials

then run:

  terraform init
  terraform plan
  terraform apply
        
To remove the config run:

  terraform destroy
  
  Umbraco POC
===============

This Terraform script configures the following:

        - Configures 1x AWS VPC
        - Configures 2x Public Subnets
        - Configures 2x Private Subnets
        - Configures 1x AWS application Loadbalacer
        - Configure 2x Windows 2016 AWS instances (T2.micro)
        - Configures IIS on port 80 
        - Pulls Unbroco  application from GIT repo (https://github.com/philiphorrocks/al_test.git)
        - Configures NAT and IGW for routing rquirements
        - Configures associated SG groups for ingress and 
        - Installs and configured Aurora (MySQL) DN for RDS with a read replica
       

Requirements
-------------

This project requires the follwoing packages to be installed:

       - Terraform
       - AWS account
       - AWS user and associated ID and secret key


How to use this playbook
------------------------
    
To use this playbook, following the steps below:

Clone files form Git repository and run vagrant command below

       - git clone https://github.com/philiphorrocks/al_code.git
       - cd al_code
       - vagrant up --provision 
       - http://192.168.56.103/al/helloworld.php (This is the LB address for testing)

This will use the Vagrantfile to build 3 Ubuntu (puppetlabs/ubuntu-14.04-64-nocm) hosts (1 x LB and 2 x Web)

       - web1:http://192.168.56.101 
       - web2:http://192.168.56.102
       - lb1: http://192.168.56.103


Ansible will install nginx on all 3 hosts. 2 hosts will be configured with a nginx web server and the remaining host will be configured as a nginx load balancer. The 2 web hosts will also have PHP and SQLite installed. The PHP application will connect directly to the backed database which will provide the message string "helloworld". 


Testing:
--------
