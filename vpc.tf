# creating the vpc
 resource "aws_vpc" "vp1" {
    cidr_block = "172.120.0.0/16"
    instance_tenancy = "default"
    tags ={
      Name = "utc-app"
      Team = "wdp"
      env = "dev"
    }
   
 }

 # create internet gateway 
 resource "aws_internet_gateway" "gtw1" {
    vpc_id = aws_vpc.vp1.id
 }

# create public subnet 1
resource "aws_subnet" "public1" {
    availability_zone = "us-east-1a"
    cidr_block = "172.120.1.0/24"
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.vp1.id
    tags = {
      Name = "utc-public-subnet-1a"
    }
}

# create public subnet 2
resource "aws_subnet" "public2" {
    availability_zone = "us-east-1b"
    cidr_block = "172.120.2.0/24"
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.vp1.id
    tags = {
      Name = "utc-public-subnet-1b"
    }
}

# create private subnet 1
resource "aws_subnet" "private1" {
    availability_zone = "us-east-1a"
    cidr_block = "172.120.3.0/24"
    vpc_id = aws_vpc.vp1.id
    tags = {
      Name = "utc-private-subnet-1a"
    }
}

# create private subnet 2
resource "aws_subnet" "private2" {
    availability_zone = "us-east-1b"
    cidr_block = "172.120.4.0/24"
    vpc_id = aws_vpc.vp1.id
    tags = {
      Name = "utc-private-subnet-1b"
    }
}

# create nat gateway
resource "aws_eip" "elastic-ip1" {  
}
resource "aws_nat_gateway" "nat1" {
    allocation_id = aws_eip.elastic-ip1.id
    subnet_id = aws_subnet.public1.id
}

# create public route table
resource "aws_route_table" "rtpub" {
    vpc_id = aws_vpc.vp1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gtw1.id
    }
}

# create private route table
resource "aws_route_table" "rtpri" {
    vpc_id = aws_vpc.vp1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat1.id
    }
}

# create public route and subnet association
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.rtpub.id
}
resource "aws_route_table_association" "rta2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.rtpub.id
}

# create private route and subnet association
resource "aws_route_table_association" "rta3" {
    subnet_id = aws_subnet.private1.id
    route_table_id = aws_route_table.rtpri.id
}
resource "aws_route_table_association" "rta4" {
    subnet_id = aws_subnet.private2.id
    route_table_id = aws_route_table.rtpri.id
}

