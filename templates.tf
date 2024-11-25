resource "aws_launch_template" "batch_environment_launch_template" {
  name_prefix = "batch_environment-${var.tag_environment}"
  user_data   = filebase64("user_data.sh")

  block_device_mappings {
    device_name = "/prod/xvda"

    ebs {
      volume_size           = var.ebs_root_volume_size
      volume_type           = "gp2"
      delete_on_termination = true

    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name          = var.compute_environment_name,
      Environment   = var.tag_environment,
      Product       = var.tag_product,
      SubProduct    = var.tag_sub_product,
      Contact       = var.tag_contact,
      Cost_code     = var.tag_cost_code,
      Orchestration = var.tag_orchestration
    }
  }
}

