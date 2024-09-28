.data
	entrada: .asciiz "Digite o numero para calcular o fatorial: "
	saida: .asciiz "fatorial do numero inserido é: "

.text
.globl main

####
#### t0 é o fatorial, t1 é o contador ( i )
####

j main

loopFatorial:
	beqz $t1, end		# branch on equal zero
	mult $t1, $t0		# multiplica o valor de $t1 (valor do fatorial), pelo valor de $t0 (contador) e o resultado vai para o registrador LO
	mflo $t0		# move o valor do registrador LO para $t0
	sub $t1, $t1, 1		# i--
	
	j loopFatorial		# repete o loop até que a primeira linha seja true

main:

	# exibir entrada
	li $v0, 4		# $v0 = registrador I/O e 4 é o comando para saida de string.
	la $a0, entrada
	syscall
	
	li $v0, 5		# $v0 = registrador I/O e 5 é o comando para entrada de inteiro.
	syscall			# numero lido está em $v0
	move $t1, $v0   	# move o valor de $v0 para $t1
	
	li $t0, 1 		# $t0 vai ser definido como o numero fatorial, $t1 definido como contador.
	
	j loopFatorial
	
end:
	#imprime a saida
	li $v0, 4
	la $a0, saida
	syscall
	#
	# exibe o resultado
	move $a0, $t0
	li $v0, 1
	syscall
