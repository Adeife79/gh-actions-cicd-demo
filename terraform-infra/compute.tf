#resource "tls_private_key" "ec2_key" {
#    algorithm = "RSA"
#    rsa_bits = 4096
#}

#resource "aws_key_pair" "app_key" {
#    key_name = "app-keypair"
#    public_key = tls_private_key.ec2_key.public_key_openssh
#}

resource "aws_instance" "app" {
    ami = var.app_ami
    instance_type = "t3.micro"
    subnet_id = aws_subnet.app_subnet.id
    security_groups = [aws_security_group.sg.id]

    key_name = "app-ssh-key"

    tags = {
        Name = "app-instance"
    }
}