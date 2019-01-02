resource "aws_launch_configuration" "webserver" {
  name   =  "${var.lcg_name}"
  image_id      = "${var.image_id}"
  #associate_public_ip_address = true
  instance_type = "${var.WEB_SERVER_INSTANCE_TYPE}"
  user_data = <<EOF
<powershell>
Install-WindowsFeature -name Web-Server -IncludeManagementTools
</powershell>
EOF
  security_groups = ["${aws_security_group.webserver.id}"]
  key_name = "${var.PEM_FILE_WEBSERVERS}"
  root_block_device
  {
    volume_type = "gp2"
    volume_size = "30"

  }
}
