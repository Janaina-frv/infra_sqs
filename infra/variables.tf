variable "queue_name" {
  description = "Nome da fila principal"
  type        = string
  default     = "feedback_urgente-sqs"
}

variable "dlq_name" {
  description = "Nome da fila DLQ"
  type        = string
  default     = "feedback_urgente-dlq"
}

variable "visibility_timeout" {
  description = "Tempo de invisibilidade da mensagem (em segundos)"
  type        = number
  default     = 30
}

variable "retention_seconds" {
  description = "Tempo de retenção da mensagem (em segundos)"
  type        = number
  default     = 86400 # 1 dia
}

variable "max_receive_count" {
  description = "Número máximo de tentativas antes de mover para a DLQ"
  type        = number
  default     = 5
}
