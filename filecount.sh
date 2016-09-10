#!/bin/bash
# Conta a quantidade de arquivos em um diretório separados por tipo.

filecount()
{
  echo -n "Calculando..."
  for ext in $(ls -R1 "$1" 2>/dev/null | egrep -o "[.]{1}[0-9a-zA-Z]{1,}$" | sed 's/\.//'); do 
    eval $(echo "((Total_$ext++))") 2>/dev/null
  done
  
  echo; for var in ${!Total_*}; do eval echo "Arquivo .${var##*_} = \$$var"; done; unset ${!Total_*}
}

# Uso: filecount <dir>
