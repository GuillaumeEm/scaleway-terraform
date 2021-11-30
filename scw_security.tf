resource "scaleway_instance_security_group" "sg-mail" {
  name = "sg-mail"
  external_rules = true
  inbound_default_policy = "drop"
  outbound_default_policy = "accept"
  stateful = true
  enable_default_security = false
}
resource "scaleway_instance_security_group_rules" "sg-mail-rules" {
  security_group_id = scaleway_instance_security_group.sg-mail.id

  inbound_rule {
    action     = "accept"
    protocol   = "ICMP"
  }
  inbound_rule {
    action     = "accept"
    protocol   = "ANY"
    ip     = scaleway_instance_server.mail.private_ip
  }

  dynamic "inbound_rule" {
    for_each = var.general_mail_ports
    content {
      action = "accept"
      port   = inbound_rule.value
    }
  }

  dynamic "inbound_rule" {
    for_each = var.private_mail_ports
    content {
      action = "accept"
      port   = inbound_rule.value
      ip     = var.friendly_ip
      }
  }
  dynamic "inbound_rule" {
    for_each = var.private_mail_ports
    content {
      action = "accept"
      port   = inbound_rule.value
      ip     = scaleway_instance_server.core.private_ip
      }
  }
}

resource "scaleway_instance_security_group" "sg-core" {
  name = "sg-core"
  external_rules = true
  inbound_default_policy = "drop"
  outbound_default_policy = "accept"
  stateful = true
  enable_default_security = false
}
resource "scaleway_instance_security_group_rules" "sg-core_rules" {
  security_group_id = scaleway_instance_security_group.sg-core.id

  inbound_rule {
    action     = "accept"
    protocol   = "ICMP"
  }
  inbound_rule {
    action     = "accept"
    protocol   = "ANY"
    ip     = scaleway_instance_server.core.private_ip
  }

  dynamic "inbound_rule" {
    for_each = var.general_core_ports
    content {
      action = "accept"
      port   = inbound_rule.value
    }
  }

  dynamic "inbound_rule" {
    for_each = var.private_core_ports
    content {
      action = "accept"
      port   = inbound_rule.value
      ip     = var.friendly_ip
      }
  }
  dynamic "inbound_rule" {
    for_each = var.private_core_ports
    content {
      action = "accept"
      port   = inbound_rule.value
      ip     = scaleway_instance_server.mail.private_ip
      }
  }
}
