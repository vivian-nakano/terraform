# Terraform Concepts

Ignore big file inside .terraform/

```
$ git filter-branch -f --index-filter 'git rm --cached -r --ignore-unmatch .terraform/'
```

## Variables
- Temos que declarar no bloco
- Aceitar tipo de argumentos: default, type, description, etc.
- Tipo da variável: string, bool, number, etc.

Opções para declarar variável
- Dentro do bloco da variável, aí coloca valor default
- Variable on the command line
- Variable Defitions (.tfvars) (tfvars.json)
- Informar terraform como variável de ambiente (utiliza export TF_VAR_nomevariavel=valorvariavel)

Linha de Comando para variáveis

```
$ export TF_VAR_location="Brazil South"
```

```
$ terraform plan -var='location-Brasil South'
```


Referenciar atributos de outros blocos

## Local Values
Recurso terraform permite dar um nome a uma determinada função

## Output values
Enviar para fora do terraform alguma informação que criamos dentro do código
$ terraform output storage_account_id
$ terraform output

## Local State
- Arquivo que o terraform cria automaticamente onde armazena infos de todos os recursos que ele geriu.
- A partir dessas infos, o terraform se torna idempotente. Aplica a mesma config varias vezes (apply), que ele não cria repetidas vezes o mesmo recurso.
- Graças a esse arquivo que o terraform é capaz de fazer isso.

State Lock Info: arquivo é criado após apply. Com state o tf sabe o que foi criado ou não. Esse arquivo impede que outros usuários utilizem/mexam no state ao mesmo tempo.

## Terraform Remote State
Armazenar remotamente o arquivo state do terraform. Várias opções, mas no curso é utilizar bucket S3 na AWS ou storage account.
By default, remote state é guardado localmente (terraform.tfstate). Mas podemos guardar remotamente.
https://developer.hashicorp.com/terraform/language/settings/backends/configuration

Necessário criar VPC, que conterá: subnet, internet gateway, route table, route table association, security group.

Terraform Remote State Data Source
Quando salvamos remotamente o tfstate e queremos usar alguma info daquele state. Ex: queremos usar a VPC criada na AWS em outros deploys que faremos, aí para acessar as infos do que já foi feito, utilizamos o TFSTATE Data Source. Data: bloco onde pegamos as infos de fora do tf e trazemos para dentro do nosso código. Importante: só pega informações dos outputs.

Criar Virtual Machine na AWS

## Terraform Import

Consegue pegar um projeto já criado e colocar em terraform.
$ terraform import aws_s3_bucket.bucket_terraform_import nome-bucket

## Provisioners

Bloco/nested block que vai dentro de bloco de recurso.
"Provisioners are a Last Resort" >> utilizar em último caso.
Rodar comando ou na máquina local (que roda terraform) ou remota (criada pelo terraform), criada pelo terraform. 
Ex: máquina virtual

1) Provisioner local-exec: https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

Executar na máquina local, onde o terraform roda, um comando específico. 
Útil em situações onde a gente faz o deploy de um recurso e precisa rodar um último script.

2) Provisioner Remote-exec
Executar na máquina remota (que a gente criou a partir do terraform) o comando específico.
Além do bloco provisioner, precisa de um bloco de conexão (connection) para realizar a conexão com essa máquina remota.

3) Provisioner File
Forma de copiar um arquivo para dentro da máquina remota. Ou copia arquivo inteiramente ou escreve algo para dentro do arquivo que nao existia dentro da máquina remota. 
Ou usa source (copiar arquivo da tua máquina para maq remota) OU content (escrever alguma info/conteúdo dentro de um arquivo na sua máquina remota)

## Módulos
Basicamente módulos são conjunto de códigos pra construir determinados recursos, que podemos reaproveitar.
Ex: conjunto de código que constrói uma VPC, salva essa pasta/diretório/módulo, e pode chamar essa pasta em outras configurações.
https://registry.terraform.io/browse/modules
Coleção de arquivos tf que servem pra construir múltiplos recursos. Empacotar e reutilizar a configuração de recursos dentro do terraform.
- Locais 
- Remotos

Considera que o diretório padrão é o ROOT MODULE. 
Child modules: armazenados localmente no mesmo lugar que o root modules.
Published modules: utilizar módulos publicados e utilizar de forma remota.
Terraform registry possui módulos verificados pela HASHICORP e publicados pela própria provider. Usuários também fazem upload do módulo (alguns podem não ser confiáveis).

O bloco do módulo sempre tem opção source, recomendado utilizar a opção version, meta-arguments/outputs. 

## Meta Arguments

Argumentos especiais e podem ser utilizados em blocos de recurso ou blocos de módulos.

1. Depends_on
Existem alguns recursos que não funcionam se não for criado na ordem correta, não consegue pegar a referência.
Utilizar o depends_on em um determinado bloco de recurso que depende de outro.

2. Count
Diz pro terraform quantas cópias daquele bloco/recurso a gente quer que crie.

3. For_each
Não é possível usar count e for each junto.
Servem para criar múltiplas cópias de um recurso utilizando apenas um bloco.
MAP OU CONJUNTO DE STRINGS.

4. Provider
Não é bloco de provider, mas tem relação
Permite que nós setamos no código mais de um provider. Ou fazer deploy em diferentes regiões (com mesmo código).

5. Lifecycle
Consta no bloco de resource, mas no bloco de módules não.
Nested block, tem opções proprias dentro dele. 
* create_before_destroy = True (primeiro constroi um novo e depois destrói o antigo)
* prevent_destroy = True ()
* ignore_changes = list of attributes

## Funções e Expressões

1. Conditional Expressions
Utiliza valor de expressao boleana para selecionar valores.
condition ? true_val : false_val

2. for Expressions
[for s in var.list : upper(s)]

"Para um valor em uma lista de valores, faça alguma coisa"

3. Splat Expressions
Forma mais concisa de fazer "for expression"

Na expressao for expression: [for o in var.list : o.id]

O mesmo para splat expression: var.list[*].id
