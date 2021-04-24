data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_subnet" "default" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    Tier = "private"
  }
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.domain
  elasticsearch_version = "7.9"

  cluster_config {
    instance_type = "t2.micro.elasticsearch"
  }

  vpc_options {
    subnet_ids = [data.aws_subnet.default.id]

    security_group_ids = [aws_security_group.default.id]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
        }
    ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

 ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
  tags = {
    Domain = "TestDomain"
  }

  depends_on = [aws_iam_service_linked_role.ess]
}

