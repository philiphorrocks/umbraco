########################################
# AWS autoscale config:                #
# 2x instances with a max of 5         #
# (eu-west2a/2b)                       #
#                                      #
#    Author: Phil H  29/12/18 v0.1     #
########################################

resource "aws_autoscaling_group" "webserver" {
  name                      = "${var.asg_name}"
  max_size                  = "${var.asg_max_size}"
  min_size                  = "${var.asg_min_size}"
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "EC2"
  desired_capacity          = "${var.asg_desired_capacity}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.webserver.name}"
  vpc_zone_identifier       = ["${aws_subnet.public_subnet.*.id}"]
  target_group_arns         = ["${aws_lb_target_group.front_end.arn}"]


}
