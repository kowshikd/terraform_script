# Instance profile
resource "aws_iam_instance_profile" "batch_environment_instance_profile" {
  name = "${replace(var.compute_environment_name, "-", "_")}_instance_profile"
  role = aws_iam_role.batch_environment_instance_role.name
}

resource "aws_iam_role" "batch_environment_instance_role" {
  name = "${replace(var.compute_environment_name, "-", "_")}_instance_role"

  assume_role_policy = data.aws_iam_policy_document.batch_environment_instance_assume_role_policy.json
}

data "aws_iam_policy_document" "batch_environment_instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "batch_environment_instance_role_attachment" {
  role       = aws_iam_role.batch_environment_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# Service role
resource "aws_iam_role" "aws_batch_service_role" {
  name = "${replace(var.compute_environment_name, "-", "_")}_aws_batch_service_role"

  assume_role_policy = data.aws_iam_policy_document.aws_batch_service_assume_role_policy.json
}

data "aws_iam_policy_document" "aws_batch_service_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "aws_batch_service_role" {
  role       = aws_iam_role.aws_batch_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBatchServiceRole"
}

resource "aws_iam_role_policy" "iam_policy" {
  name_prefix = "${var.compute_environment_name}_S3_SSM"
  role        = aws_iam_role.batch_environment_instance_role.name
  policy      = file("${path.module}/iam_role_policy.tmpl")
}


//////  New policy to get New Relic License from parameter store- Shared bakery AMIs will automatically use this to look up the license at startup, so no need for secret, and greatly reduces User Data.

resource "aws_iam_role_policy" "new_relic_license" {

  name_prefix = "${var.compute_environment_name}_new_relic_license"
  role        = aws_iam_role.batch_environment_instance_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "newreliclicense",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ssmdescribe",
            "Effect": "Allow",
            "Action": "ssm:DescribeParameters",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "dp-ip-async-batch_exec_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role_policy" "job_definition_role_policy_1" {

  name_prefix = "${var.compute_environment_name}_job_definition1"
  role        = aws_iam_role.ecs_task_execution_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "job_definition_role_policy_2" {

  name_prefix = "${var.compute_environment_name}_job_definition2"
  role        = aws_iam_role.ecs_task_execution_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:Describe*",
                "cloudwatch:*",
                "logs:*",
                "sns:*",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:GetRole"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:CreateServiceLinkedRole",
            "Resource": "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
            "Condition": {
                "StringLike": {
                    "iam:AWSServiceName": "events.amazonaws.com"
                }
            }
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "job_definition_role_policy_3" {

  name_prefix = "${var.compute_environment_name}_job_definition3"
  role        = aws_iam_role.ecs_task_execution_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudWatchEventsFullAccess",
            "Effect": "Allow",
            "Action": "events:*",
            "Resource": "*"
        },
        {
            "Sid": "IAMPassRoleForCloudWatchEvents",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "arn:aws:iam::*:role/AWS_Events_Invoke_Targets"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "job_definition_role_policy_4" {

  name_prefix = "${var.compute_environment_name}_job_definition4"
  role        = aws_iam_role.ecs_task_execution_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ecr:DescribeImageScanFindings",
                "ecr:GetLifecyclePolicyPreview",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:DescribeImages",
                "ecr:GetAuthorizationToken",
                "ecr:DescribeRepositories",
                "ecr:ListTagsForResource",
                "ecr:ListImages",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetRepositoryPolicy",
                "ecr:GetLifecyclePolicy"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
