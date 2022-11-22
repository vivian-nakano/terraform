terraform {
    ##vão diversas configs básicas do terraform
}

provider "aws" {
    ##nome do provider utilizado:
}

resource "aws_instance" "name" {
    ##seta o nome do resource que quer criar
    ##segunda aspas: nome que quisermos, nome interno dentro da config do terraform
}

data "aws_ami" "name" {
    ##primeiras aspas: tipo de data => busca infos de uma imagem aws 
    ##segunda aspas: qualquer nome para referenciar essa informação
}

module "vpc" {
    ##referencia tanto o modulo que a gente cria
    ##referencia o módulo do registro do terraform
}

variable "ip" {
    ##declaração de variavel que a gente usa dentro da config do terraform
}