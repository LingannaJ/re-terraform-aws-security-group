resource "aws_security_group" "allow_tls" {
  name        = local.sg_name_final
  description = var.sg_description
  vpc_id      = var.vpc_id


  dynamic "egress" {
    for_each = var.outboud_rules
    content {
      from_port       = egress.value["from_port"]
      to_port         = egress.value["to_port"]
      protocol        = egress.value["protocol"]
      cidr_blocks     = egress.value["cidr_blocks"]
    }
  }


  tags = merge(
    var.common_tags,
    var.sg_tags,
    {
        Name = local.sg_name_final

    }
  )
}