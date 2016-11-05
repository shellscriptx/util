#!/bin/bash

#----------------------------------------------------------------------------------------------------
# Data:			5 de novembro de 2016
# Criado por:	Juliano Santos [SHAMAN]
# Script:		text_align.sh
# Página:		https://www.facebook.com/shellscriptx
# Github:		https://github.com/shellscriptx
# Descrição:	Lẽ o texto e altera a formatação de saida. Com o comando 'sed' + 'expressão regular' 
#				é realizado a inserção de espaçamentos de colunas para formatação do texto.
#----------------------------------------------------------------------------------------------------

# Nome do script
SCRIPT=$(basename "$0")

# Lê todos os parâmetros passados com o script e armazena em 'OPTS'
OPTS=$(getopt -o 'edca' -l 'esquerda,direita,centro,ajuda' -n $SCRIPT -- "$@")

# Desloca 1 índice dos elementos
shift $((OPTIND - 1))

# Atribui os argumentos aos parâmetros da posição.
eval set -- "$OPTS"

# Executa o loop enquanto houver parâmetros
while [ $# -gt $OPTIND ]
do
	# Lẽ o parâmetro atual.
	case $1 in
		# Alinhamento a esquerda
		-e|--esquerda)
			# Remove todos os espaços iniciais do texto.
			sed -r 's/^\s*//'
			# Desloca um índice
			shift
			;;
		# Alinhamento a direita.
		-d|--direita)
			# Obtem o tamanho atual de colunas e subtrai '1' para escapar
			# o caractere '\n', evitando assim a inserção de uma nova linha 
			# em branco no final da coluna.
			COLS=$(($(tput cols)-1))
			# A expressão regular remove todos os espaços em branco depois da ultima palavra até o final da linha.
			# Depois é iniciado um loop onde é inserido um espaço no inicio durante os primeiros "$COLS' caracteres.
			# Esse processo empurra o texto para o final da linha.
			sed -r "s/\s*$//;:a;s/^.{1,$COLS}$/ &/;ta"
			shift	# Desloca 1 índice
			;;
		# Centralizado
		-c|--centro)
			# Obtem o tamanho atual de colunas, porém subtrai '2', para compensar tanto
			# o ponto incial apartir do centro e o caractere '\n' no final da linha
			COLS=$(($(tput cols)-2))
			# Remove todos os espaços iniciais e finais do texto.
			# Inicia o loop, inserindo um espaço no inicio e fim do texto nos primeiros "$COLS" caracteres.
			# Com isso é inserido uma quantidade idêntica de espaços tanto no inicio quanto no final, deixando
			# o texto no centro da tela. 
			sed -r "s/^\s*//;s/\s*$//;:a;s/^.{1,$COLS}$/ & /;ta"
			shift	# Desloca um índice.
			;;
		# Ajuda
		-a|--ajuda)
			echo "Uso: $SCRIPT [FORMATACAO]"
			echo "Lẽ o texto de entrada e aplica a formatação, alterando o alinhamento na saida."
			echo
			echo "FORMATAÇÕES:"
			echo "-e, --esquerda    Alinha o texto a esquerda."
			echo "-d, --direita     Alinha o texto a direita."
			echo "-c, --centro      Centraliza o texto."
			echo
			echo "by; Juliano Santos [SHAMAN]"
			break
			;;
		# Parâmetro inválido.
		*)
			echo "Tente: '$SCRIPT --ajuda' para mais informações." 1>&2
			exit 1
			;;
	esac
done

exit 0
# FIM
