# AWS Instance
resource "aws_instance" "jenkinsAgent" {
    ami = "ami-08c40ec9ead489470"
    instance_type = "t2.micro"
    key_name = "deploy"
    vpc_security_group_ids = [data.aws_security_group.sg.id]

    user_data = "${file("nginx.sh")}"

    tags = {
      "Name" = "Jenkins Deploy Agent"
    }
  
}

# Seleted Security Group
data "aws_security_group" "sg" {
  id = "sg-0a52f7741f998e9eb"
}

# IP Address of Agent
output "agentPublicIp" {
   description = "Public IP address of the EC2 instance"
   value       = aws_instance.jenkinsAgent.public_ip
}

