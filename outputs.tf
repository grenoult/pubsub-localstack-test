output "sns_topic_arn" {
  description = "SNS Topic ARN"
  value       = aws_sns_topic.resourceA.arn
}

output "sqs_queue_url" {
  description = "SQS Queue URL"
  value       = aws_sqs_queue.resourceB.url
}
