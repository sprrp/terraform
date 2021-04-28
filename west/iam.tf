resource "aws_iam_service_linked_role" "main" {
  default     = "true"
 aws_service_name = "es.amazonaws.com"
}
