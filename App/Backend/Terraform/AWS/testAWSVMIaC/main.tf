data "cloudinit_config" "example" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = file("${path.module}/cloud-init.yaml")
  }
}
resource "aws_key_pair" "my_ssh_key" {
  key_name   = "my-key"
  public_key = file(var.ssh_public_key_path)
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id       = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.allow_http.id] 
  user_data = data.cloudinit_config.example.rendered
  key_name = aws_key_pair.my_ssh_key.key_name
  tags = var.tags
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-north-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]
  map_public_ip_on_launch = true
}


# add ssh here
resource "aws_security_group" "allow_http" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ips
  }
  # in order to install cloud-init configuration, this rule is required (maybe not precisely, but for test simplicity leave it)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}