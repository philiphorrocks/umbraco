resource "aws_security_group" "rds-poc"
{
  tags{
    Name = "${var.PROJECT_NAME}-rds-poc"
  }
  name = "${var.PROJECT_NAME}-rds-poc"
  vpc_id     = "${aws_vpc.main.id}"

  # Inbound rule (only from VPC)
  ingress
  {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks  = ["${var.VPC_CIDR_BLOCK}"]

  }

  # Outbound rule (default allow all)
  egress
  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
