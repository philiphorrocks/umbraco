########## VPC Variables #################
##########################################

#Project name
variable "PROJECT_NAME" {

 default = "WebApp"
}

# CIDR block range for the VPC
variable "VPC_CIDR_BLOCK" {

  default = "10.0.0.0/16"
}

# Define Public Subnets in list
variable "VPC_PUBLIC_SUBNET" {

 default = ["10.0.1.0/24", "10.0.2.0/24"]
 type = "list"
}

# Define Private Subnets in list
variable "VPC_PRIVATE_SUBNET" {

 default = ["10.0.3.0/24", "10.0.4.0/24"]
 type = "list"
}

# AV Zones - eu-west is default
variable "VPC_AV_ZONES" {

 default = ["eu-west-2a", "eu-west-2b"]
 type = "list"
}


######## Ec2 /Autoscaling Variables ############
################################################

variable "image_id" {
  default = "ami-06a27ce600d784c71"
}

variable "asg_name" {
  default = "webservers"
}

variable "asg_max_size" {
  default = 5
}

variable "asg_min_size" {
  default = 2
}

variable "asg_health_check_grace_period" {
  default = 30
}

variable "asg_desired_capacity" {
  default = 2
}

variable "lcg_name" {
  default = "webserver-asg-lc"
}

variable "PEM_FILE_WEBSERVERS" {
  default = "umbraco_poc"
}

variable "USER_DATA_FOR_WEBSERVER" {
  default = "install_components.ps1"
}

variable "WEB_SERVER_INSTANCE_TYPE" {
  default = "t2.micro"
}
######## RDS Variables #########################
################################################

variable "environment_name" {
    default = "POC"
}

variable "rds_master_username" {
   default = "test01"
}

variable "rds_master_password" {
  default = "password123"
}

variable "instance_class" {
  default = "db.t2.small"
}

variable "cluster_identifier" {
  default = "aurora-cluster-poc"
}

variable "skip_final_snapshot" {
  default = "true"
}

variable "database_name" {
  default = "umbraco_poc"
}


variable "master_username" {
  default = "umbraco"
}

variable "master_password" {
  default = "password123"
}
