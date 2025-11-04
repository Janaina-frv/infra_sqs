resource "aws_sqs_queue" "feedback_urgente" {
  name                      = "feedback_urgente-sqs"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
}
