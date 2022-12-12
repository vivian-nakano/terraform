output "subnet_id" {
    value = aws_subnet.subnet[*].id
}
##Cria uma lista com os IDs de todas as subnets
##Mesma coisa que fizemos anteriormente, no qual foi criado tres subnets e foi retornado o id das subnets.