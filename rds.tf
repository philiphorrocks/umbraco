########################################
# AWS RDS config:                      #
# 2x MySQL DBs (eu-west2a/2b)          #
#                                      #
#    Author: Phil H  29/12/18 v0.1     #
########################################


# Create AWS MySQL DB resource

# Instance
resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-poc-${count.index}"
  cluster_identifier = "${aws_rds_cluster.umbraco_poc.id}"
  instance_class     = "${var.instance_class}"
}

# Cluster
resource "aws_rds_cluster" "umbraco_poc" {
  cluster_identifier = "${var.cluster_identifier}"
  availability_zones = ["${var.VPC_AV_ZONES}"]
  db_subnet_group_name = "${aws_db_subnet_group.RDS_subnet.id}"
  skip_final_snapshot = "${var.skip_final_snapshot}"
  final_snapshot_identifier    = "${var.PROJECT_NAME}-final"
  database_name      = "${var.database_name}"
  master_username    = "${var.master_username}"
  master_password    = "${var.master_password}"
}
