output "sqs_queue_url" {
  description = "URL da fila principal"
  value       = aws_sqs_queue.feedback_urgente.id
}

output "sqs_queue_arn" {
  description = "ARN da fila principal"
  value       = aws_sqs_queue.feedback_urgente.arn
}

output "dlq_queue_url" {
  description = "URL da fila DLQ"
  value       = aws_sqs_queue.dlq_feedback.id
}

output "dlq_queue_arn" {
  description = "ARN da fila DLQ"
  value       = aws_sqs_queue.dlq_feedback.arn
}
