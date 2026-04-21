resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block

    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "app_subnet" {
    vpc_id           = aws_vpc.vpc.id
    cidr_block        = var.app_subnet_cidr
    availability_zone = var.app_subnet_az
    map_public_ip_on_launch =  true

    tags = {
        Name = var.app_subnet_name
    }   
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_cidr
    availability_zone =  var.private_subnet_az 

    tags = {
        Name = var.private_subnet_name
    }  
} 

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = var.igw_name
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = var.public_rt_name
    }
}

resource "aws_route_table_association" "rt_association" {
    depends_on = [aws_subnet.app_subnet]
    subnet_id = aws_subnet.app_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "sg" {
    name = "gh-actions-demo1-sg"
    description = "Allow inbound HTTP and App Port Traffic"
    vpc_id = aws_vpc.vpc.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "App Port"
        from_port = var.app_port
        to_port = var.app_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
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