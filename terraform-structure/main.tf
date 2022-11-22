terraform {
    required_version = "1.1.0"
    #required_version = ">= 1.0.0"
    #required_version = ">= 1.0.0, < 1.2.0"
    #required_version = "~> 1.0.0" funciona da 1.0.0 até 1.1.n

    required_providers {
      aws = {
        version = "3.50.0"
        source = "hashicorp/aws"
      }
      azurerm = {
        version = "2.70.0"
        source = "hashicorp/azurerm"
      }
    }

    backend "s3" {
        #guarda state do terraform de forma remota, no s3 bucket
        #essa parte vai estar as configs da state
    }
}
