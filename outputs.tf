output "compute_environment_aft_arn" {
  description = "The arn of the computer environment for on-demand or for spot."
  value       = aws_batch_compute_environment.batch_aft_environment.arn
}

output "compute_environment_gc_arn" {
  description = "The arn of the computer environment for on-demand or for spot."
  value       = aws_batch_compute_environment.batch_gc_environment.arn
}

output "compute_environment_matcher_arn" {
  description = "The arn of the computer environment for on-demand or for spot."
  value       = aws_batch_compute_environment.batch_matcher_environment.arn
}

output "compute_environment_sg_id" {
  description = "The id of the security group associated with the compute environment"
  value       = aws_security_group.batch_environment_sg.id
}

output "default_queue_aft_arn" {
  description = "The arn of the default queue"
  value       = aws_batch_job_queue.default_aft_queue.arn
}

output "default_queue_gc_arn" {
  description = "The arn of the default queue"
  value       = aws_batch_job_queue.default_gc_queue.arn
}

output "default_queue_matcher_arn" {
  description = "The arn of the default queue"
  value       = aws_batch_job_queue.default_matcher_queue.arn
}

output "default_aft_queue_name" {
  description = "The name of the default queue"
  value       = aws_batch_job_queue.default_aft_queue.name
}

output "default_gc_queue_name" {
  description = "The name of the default queue"
  value       = aws_batch_job_queue.default_gc_queue.name
}

output "default_matcher_queue_name" {
  description = "The name of the default queue"
  value       = aws_batch_job_queue.default_matcher_queue.name
}

output "batch_environment_instance_role_arn" {
  description = "The arn of the batch_environment_instance_role"
  value       = aws_iam_role.batch_environment_instance_role.arn
}

output "aws_batch_service_role_arn" {
  description = "The arn of the aws_batch_service_role"
  value       = aws_iam_role.aws_batch_service_role.arn
}

output "batch_environment_instance_profile_arn" {
  description = "The arn of the batch_environment_instance_profile"
  value       = aws_iam_instance_profile.batch_environment_instance_profile.arn
}

output "compute_environment_sg_arn" {
  description = "The arn of the security group associated with the compute environment"
  value       = aws_security_group.batch_environment_sg.arn
}

output "compute_environment_aft_ecs_cluster_arn" {
  description = "The arn of the underlying Amazon ECS cluster used by the compute environment."
  value       = aws_batch_compute_environment.batch_aft_environment.ecs_cluster_arn
}

output "compute_environment_gc_ecs_cluster_arn" {
  description = "The arn of the underlying Amazon ECS cluster used by the compute environment."
  value       = aws_batch_compute_environment.batch_gc_environment.ecs_cluster_arn
}

output "compute_environment_matcher_ecs_cluster_arn" {
  description = "The arn of the underlying Amazon ECS cluster used by the compute environment."
  value       = aws_batch_compute_environment.batch_matcher_environment.ecs_cluster_arn
}