resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "vpc-terraform"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index}.0/24" ##index = 1, 2, 3 e assim por diante

  count = 3

  tags = {
    Name = "subnet-terraform-${count.index}"
  }
}

### AQUI É O OUTPUTS.TF

### Antes referenciava assim:
output "subnet_id" {
  value = aws_subnet.subnet.id
}

### Mas como tem count, nao pode simplesmente referenciar o id
output "subnet_0_id" {
  value = aws_subnet.subnet[0].id
}

output "subnet_1_id" {
  value = aws_subnet.subnet[1].id
}

output "subnet_2_id" {
  value = aws_subnet.subnet[2].id
}
