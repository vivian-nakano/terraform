#ARQUIVO OUTPUT
output "subnet_id" {
    value = [for subnet in aws_subnet.subnet : subnet.id]
}

##Para cada subnet que estão sendo criadas nesse bloco, queremos que mostre o ID de cada uma.