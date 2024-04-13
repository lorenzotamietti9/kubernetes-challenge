provider "aws" {
  region = "eu-west-1"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "nodes_security_group" {
  name        = "nodes_security_group"
  description = "security groups for kube nodes"
  vpc_id      = aws_default_vpc.default.id
  tags = {
    Name = "nodes_security_group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "nodes_security_group_rule_tls" {
  security_group_id = aws_security_group.nodes_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "nodes_security_group_rule_http" {
  security_group_id = aws_security_group.nodes_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "nodes_security_group_rule_ssh" {
  security_group_id = aws_security_group.nodes_security_group.id
  cidr_ipv4         = "93.39.139.61/32"
  from_port         = 22
  ip_protocol       = "ssh"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "nodes_security_group_rule_internal" {
  security_group_id = aws_security_group.nodes_security_group.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  ip_protocol       = -1

}

resource "aws_instance" "node_master" {
  ami                    = "ami-0eb11ab33f229b26c"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.nodes_security_group.id]


  tags = {
    Name = "NodeMaster"
  }
}

resource "aws_instance" "node_worker1" {
  ami                    = "ami-0eb11ab33f229b26c"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.nodes_security_group.id]

  tags = {
    Name = "NodeWorker1"
  }
}

resource "aws_instance" "node_worker2" {
  ami                    = "ami-0eb11ab33f229b26c"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.nodes_security_group.id]

  tags = {
    Name = "NodeWorker2"
  }
}