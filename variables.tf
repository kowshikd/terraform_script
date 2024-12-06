variable "account_id" {
  description = "The account that the batch environment is to be deployed into."
  type        = string
}

variable "compute_environment_name" {
  description = "The name that will be used for the batch environment and the associated resources."
  type        = string
}

variable "aft_compute_environment_name" {
  description = "The name that will be used for the batch environment and the associated resources."
  type        = string
}

variable "gc_compute_environment_name" {
  description = "The name that will be used for the batch environment and the associated resources."
  type        = string
}

variable "matcher_compute_environment_name" {
  description = "The name that will be used for the batch environment and the associated resources."
  type        = string
}

variable "input_transformer_environment_name" {
  description = "The name that will be used for the batch environment and the associated resources."
  type        = string
}

variable "output_transformer_environment_name" {
  description = "The name that will be used for the batch environment and the associated resources."
  type        = string
}

variable "aft_instance_types" {
  description = "The instance types that may be launched. You can specify instance families to launch any instance type within those families (for example, c5, c5n, or p3), or you can specify specific sizes within a family (such as c5.8xlarge). Note that metal instance types are not in the instance families (for example c5 does not include c5.metal.) You can also choose optimal to pick instance types (from the C, M, and R instance families) on the fly that match the demand of your job queues.  NOTE: When you create a compute environment, the instance types that you select for the compute environment must share the same architecture. For example, you can't mix x86 and ARM instances in the same compute environment."
  type        = list(string)
  default     = ["m5.2xlarge", "m5a.2xlarge"]
}

variable "gc_instance_types" {
  description = "The instance types that may be launched. You can specify instance families to launch any instance type within those families (for example, c5, c5n, or p3), or you can specify specific sizes within a family (such as c5.8xlarge). Note that metal instance types are not in the instance families (for example c5 does not include c5.metal.) You can also choose optimal to pick instance types (from the C, M, and R instance families) on the fly that match the demand of your job queues.  NOTE: When you create a compute environment, the instance types that you select for the compute environment must share the same architecture. For example, you can't mix x86 and ARM instances in the same compute environment."
  type        = list(string)
  default     = ["m5.xlarge", "m5a.xlarge"]
}

variable "matcher_instance_types" {
  description = "The instance types that may be launched. You can specify instance families to launch any instance type within those families (for example, c5, c5n, or p3), or you can specify specific sizes within a family (such as c5.8xlarge). Note that metal instance types are not in the instance families (for example c5 does not include c5.metal.) You can also choose optimal to pick instance types (from the C, M, and R instance families) on the fly that match the demand of your job queues.  NOTE: When you create a compute environment, the instance types that you select for the compute environment must share the same architecture. For example, you can't mix x86 and ARM instances in the same compute environment."
  type        = list(string)
  default     = ["m5.2xlarge", "m5a.2xlarge"]
}

variable "input_transformer_instance_types" {
  description = "The instance types that may be launched. You can specify instance families to launch any instance type within those families (for example, c5, c5n, or p3), or you can specify specific sizes within a family (such as c5.8xlarge). Note that metal instance types are not in the instance families (for example c5 does not include c5.metal.) You can also choose optimal to pick instance types (from the C, M, and R instance families) on the fly that match the demand of your job queues.  NOTE: When you create a compute environment, the instance types that you select for the compute environment must share the same architecture. For example, you can't mix x86 and ARM instances in the same compute environment."
  type        = list(string)
  default     = ["optimal", "m5.2xlarge", "m5a.2xlarge"]
}

variable "output_transformer_instance_types" {
  description = "The instance types that may be launched. You can specify instance families to launch any instance type within those families (for example, c5, c5n, or p3), or you can specify specific sizes within a family (such as c5.8xlarge). Note that metal instance types are not in the instance families (for example c5 does not include c5.metal.) You can also choose optimal to pick instance types (from the C, M, and R instance families) on the fly that match the demand of your job queues.  NOTE: When you create a compute environment, the instance types that you select for the compute environment must share the same architecture. For example, you can't mix x86 and ARM instances in the same compute environment."
  type        = list(string)
  default     = ["m5.8xlarge"]
}

variable "ebs_root_volume_size" {
  description = "The size in GB of the root volume of the instances launched in the compute environment"
  type        = number
  default     = 1000
}

variable "min_vcpus" {
  description = "The min number of cpu the cluster will keep running"
  default     = 0
  type        = number
}

variable "aft_max_vcpus" {
  description = "The max number of cpu the cluster will run"
  default     = 1024
  type        = number
}

variable "gc_max_vcpus" {
  description = "The max number of cpu the cluster will run"
  default     = 256
  type        = number
}

variable "matcher_max_vcpus" {
  description = "The max number of cpu the cluster will run"
  default     = 1024
  type        = number
}

variable "input_transformer_max_vcpus" {
  description = "The max number of cpu the cluster will run"
  default     = 1024
  type        = number
}

variable "output_transformer_max_vcpus" {
  description = "The max number of cpu the cluster will run"
  default     = 1024
  type        = number
}


variable "vpc_id" {
  description = "The id of the vpc where the batch environment will sit."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet ids where to create the compute environment.  This may require use of the split function if using a remote state."
  type        = list(string)
}

variable "default_queue_priority" {
  description = "The priorty of the default queue"
  default     = "1"
  type        = string
}

variable "ec2_key_pair" {
  description = "The EC2 key pair that is used for instances launched in the compute environment."
  default     = "dp-ip-async-api-keypair"
  type        = string
}


variable "compute_resources_type" {
  description = "(Required) The type of compute environment. Valid items are EC2 or SPOT."
  default     = "EC2"
  type        = string
}



variable "tag_environment" {
  description = "The environment in which the batch resources are deployed, e.g. dev/staging/prod/live"
  type        = string
}

variable "tag_product" {
  description = "The product (or team), e.g. Veritas"
  type        = string
  default     = ""
}

variable "tag_sub_product" {
  description = "The sub-product (or application), e.g. api"
  type        = string
  default     = ""
}

variable "tag_contact" {
  description = "Specifies the group email address of the team responsible for the support of this resource."
  type        = string
}

variable "tag_cost_code" {
  description = "Track costs to align with various costing sources: cost centre, project code, PnL budget."
  type        = string
}

variable "tag_orchestration" {
  description = "Path to Git for control repository."
  type        = string
}

variable "tag_description" {
  description = "Description of the use of this module."
  type        = string
}

variable "global_region" {
  description = "The region of the account that the module is deployed in."
  type        = string
}

variable "container_image_aft" {
  description = "Container image for the Aft"
  type        = string
}

variable "container_image_gc" {
  description = "Container image for the gc"
  type        = string
}

variable "container_image_matcher" {
  description = "Container image for the matcher"
  type        = string
}

variable "container_image_output_transformer" {
  description = "Container image for the output transformer"
  type        = string
}

variable "container_image_input_transformer" {
  description = "Container image for the Input transformer"
  type        = string
}

variable "sg_groups" {
  description = "Sg for the compute environment"
  type = list(string)
}

variable "filesystemid" {
  description = "Filesystem id for the compute environment"
  type = string
}

variable "backend_bucket" {
  description = "The name of the S3 bucket for the backend"
  type        = string
}

variable "backend_key" {
  description = "The path to the state file inside the S3 bucket"
  type        = string
}

variable "backend_region" {
  description = "The AWS region where the S3 bucket is located"
  type        = string
}