

Ignore big file inside .terraform/
git filter-branch -f --index-filter 'git rm --cached -r --ignore-unmatch .terraform/'

Variables: 
- Temos que declarar no bloco
- Aceitar tipo de argumentos: default, type, description, etc.
- Tipo da variável: string, bool, number, etc.

Opções para declarar variável
- Dentro do bloco da variável, aí coloca valor default
- Variable on the command line
- Variable Defitions (.tfvars) (tfvars.json)
- Informar terraform como variável de ambiente (utiliza export TF_VAR_nomevariavel=valorvariavel)

Linha de Comando para variáveis

$ export TF_VAR_location="Brazil South"
$ terraform plan -var='location-Brasil South'
