data "aws_ami" "base_ami" {
  most_recent = true
  name_regex  = "tio_base_ecs_amz_linux_2023-*"
  owners      = ["702267635140"]
}

resource "aws_batch_compute_environment" "batch_aft_environment" {
  compute_environment_name = "${var.aft_compute_environment_name}_${var.tag_environment}_test_2024"

  compute_resources {
    instance_role = aws_iam_instance_profile.batch_environment_instance_profile.arn

    instance_type = var.aft_instance_types
    image_id      = data.aws_ami.base_ami.image_id
    type          = var.compute_resources_type


    launch_template {
      launch_template_id = aws_launch_template.batch_environment_launch_template.id
      version            = aws_launch_template.batch_environment_launch_template.latest_version
    }

    max_vcpus     = var.aft_max_vcpus
    min_vcpus     = var.min_vcpus
    desired_vcpus = var.min_vcpus

    security_group_ids = [aws_security_group.batch_environment_sg.id]

    subnets = var.subnet_ids

    ec2_key_pair = var.ec2_key_pair
  }

  service_role = aws_iam_role.aws_batch_service_role.arn
  type         = "MANAGED"
  depends_on   = [aws_iam_role_policy_attachment.aws_batch_service_role]

  tags = {
    Name          = var.aft_compute_environment_name,
    Environment   = var.tag_environment,
    Product       = var.tag_product,
    Sub_product   = var.tag_sub_product,
    Contact       = var.tag_contact,
    Cost_code     = var.tag_cost_code,
    Orchestration = var.tag_orchestration
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [compute_resources.0.desired_vcpus]
  }
}

resource "aws_batch_job_queue" "default_aft_queue" {
  name                 = "${var.aft_compute_environment_name}-default-queue_${var.tag_environment}_test_2024"
  state                = "ENABLED"
  priority             = var.default_queue_priority
  compute_environments = [aws_batch_compute_environment.batch_aft_environment.arn]

  tags = {
    Name          = var.aft_compute_environment_name,
    Environment   = var.tag_environment,
    Product       = var.tag_product,
    Sub_product   = var.tag_sub_product,
    Contact       = var.tag_contact,
    Cost_code     = var.tag_cost_code,
    Orchestration = var.tag_orchestration
  }
}


resource "aws_batch_job_definition" "default_aft_job_definition" {
  name = "${var.aft_compute_environment_name}-default-job-definition_${var.tag_environment}_test_2024"
  type = "container"

  container_properties = <<CONTAINER_PROPERTIES
{
    "command": ["true"],
    "image": "${var.container_image_aft}",
    "memory": 16384,
    "vcpus": 8,
    "executionRoleArn": "${aws_iam_role.ecs_task_execution_role.arn}",
	"jobRoleArn": "${aws_iam_role.ecs_task_execution_role.arn}",

    "volumes": [
      {
        "host": {
          "filesystemid": "${var.filesystemid}",
          "rootDirectory": "/aft"
        },
        "name": "shared"
      }
    ],
    "environment": [
        {"name": "VARNAME", "value": "VARVAL"}
    ],
    "mountPoints": [
        {
          "sourceVolume": "shared",
          "containerPath": "/opt/shared",
          "readOnly": false
        }
    ],
    "timeout": {
        "attemptDurationSeconds": 3600
    }
}
CONTAINER_PROPERTIES

  tags = {
    Name          = var.aft_compute_environment_name,
    Environment   = var.tag_environment,
    Product       = var.tag_product,
    Sub_product   = var.tag_sub_product,
    Contact       = var.tag_contact,
    Cost_code     = var.tag_cost_code,
    Orchestration = var.tag_orchestration
  }
}

