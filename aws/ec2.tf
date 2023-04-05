resource "aws_ebs_volume" "example" {
  size              = 8
  availability_zone = "us-east-1a"
  tags = {
    Name = "HelloWorld 01"
  }
}

resource "aws_instance" "api-canary01" {
  ami           = "ami-005f9685cb30f234b"
  instance_type = "t2.micro"

  tags = {
    Name    = "api-canary01"
    Service = "api"
    Env     = "canary"
    OS      = "redhat"
  }
}

resource "aws_instance" "api-canary02" {
  ami           = "ami-005f9685cb30f234b"
  instance_type = "t2.micro"

  tags = {
    Name    = "api-canary02"
    Service = "api"
    Env     = "canary"
  }
}

resource "aws_instance" "rpc-canary01" {
  ami           = "ami-005f9685cb30f234b"
  instance_type = "t5.large"

  tags = {
    Name    = "rpc-canary01"
    Service = "rpc"
    Env     = "canary"
    Cluster = "rpc"
    OS      = "linux"
  }
}
