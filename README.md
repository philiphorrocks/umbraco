 
Umbraco POC
===============

This Terraform script configures the following:

        - Configures 1x AWS VPC
        - Configures 2x Public Subnets
        - Configures 2x Private Subnets
        - Configures 1x AWS application Loadbalacer
        - Configure 2x Windows 2016 AWS instances (T2.micro)
        - Configures IIS on port 80 
        - Pulls Unbroco  application from GIT repo (https://github.com/umbraco/Umbraco-CMS.git)
        - Configures NAT and IGW for routing rquirements
        - Configures associated SG groups for ingress and 
        - Installs and configured Aurora (MySQL) DN for RDS with a read replica
       

Requirements
-------------

This project requires the follwoing packages to be installed:

       - Terraform 1.x
       - AWS account
       - AWS user and associated ID and secret key
       - *.pem key from VPC


How to use this Terraform script
--------------------------------
    
To use this Terraform script, following the steps below:

Clone files form Git repository and run the Terrafomrm commands below

       - git clone https://github.com/philiphorrocks/umbraco.git
       - cd umbrraco
       - Update the provision.tf file
       - Add your .pem key (umbraco_poc)
       
then run:

        - terraform init
        - terraform plan
        - terraform apply

This will create the components and output the loadbalancer adddress.

To destroy the AWS environment, please run the following command

        - terraform destroy
