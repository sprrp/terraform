resource "aws_iam_service_linked_role" "es" {
  create_iam_service_linked_role = false
 aws_service_name = "es.amazonaws.com"
}
