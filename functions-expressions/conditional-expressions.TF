##ARQUIVO VARIABLES

variable "environment" {
    description = "Ambiente onde recurso será criado"
    type = string
}



##ARQUIVO NETWORK

resource "aws_vpc" {

    count = var.environment == "prod" ? 1 : 0 
    ##Se a variavel estiver apontando prod, o count será 1. Caso não, o count será 0.

    cidr_block = "10.0.0.0/16"

    tags = {
        "Name" = "vpc-terraform"
    }
}

## No exemplo ele set a variável via linha de comando (CLI)
## export TF_VAR_environment=develop // export TF_VAR_environment=develop