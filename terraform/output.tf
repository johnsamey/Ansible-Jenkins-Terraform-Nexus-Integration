resource "local_file" "inventory" {
  content = <<EOF
[app]
${join("\n", [for instance in aws_instance.nexus_instance : instance.public_ip if instance.public_ip != null])}
EOF
  filename = "inventory.txt"
}

