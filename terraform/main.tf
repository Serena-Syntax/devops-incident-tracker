# AWS Provider Konfiguration
terraform {
required_providers {
aws = {
source = "hashicorp/aws"
version = "~> 4.0"
}
}
}

provider "aws" {
region = "eu-central-1" # Frankfurt Region
}

# VPC fuer das Incident Tracker Projekt
resource "aws_vpc" "main_vpc" {
cidr_block = "10.0.0.0/16"
enable_dns_hostnames = true

tags = {
Name = "incident-tracker-vpc"
Environment = "Production"
}
}

# Öffentliches Subnetz fuer Webserver
resource "aws_subnet" "public_subnet" {
vpc_id = aws_vpc.main_vpc.id
cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = true

tags = {
Name = "incident-tracker-public-subnet"
}
}

# Sicherheitsgruppe (Security Group) fuer HTTP & SSH
resource "aws_security_group" "web_sg" {
name = "incident-tracker-sg"
description = "Erlaubt HTTP und SSH Zugriff"
vpc_id = aws_vpc.main_vpc.id

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 5000
to_port = 5000
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
