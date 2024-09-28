.data
	entradaElementoVetor: .asciiz "Digite o elemento do vetor: "
	saida: .asciiz "Vetor ordenado: "
	espace: .asciiz " "

vetor: .space 40 # 40 bytes para 10 inteiros

.text
.globl main

j main

	
	

bubbleSort:
    li $t2, 10
    
    doWhile:
        li $s0, 0             				# trocado = false
        li $t0, 0             				# i = 0

    forLoop:
        # Testa se i < tamVetor - 1
        sub $t3, $t2, 1      		 		# $t3 = tamVetor - 1
        bge $t0, $t3, endFor  				# Se i >= tamVetor - 1, sai do loop

        # Carrega vetor[i] em $t6
        sll $t4, $t0, 2      				# $t4 = i * 4 (multiplica i por 4 para indexar vetor)
        lw $t6, vetor($t4)    				# Carrega vetor[i] em $t6

        # Carrega vetor[i+1] em $t7
        addi $t1, $t0, 1      				# $t1 = i + 1
        sll $t5, $t1, 2       				# $t5 = (i + 1) * 4 (multiplica i+1 por 4)
        lw $t7, vetor($t5)    				# Carrega vetor[i+1] em $t7

        # Se vetor[i] > vetor[i+1]
        ble $t6, $t7, proxIndice  			 # Se vetor[i] <= vetor[i+1], vai para o próximo i

        # Troca vetor[i] e vetor[i+1]
        move $t8, $t6         				# $t8 = vetor[i] (aux = vetor[i])
        sw $t7, vetor($t4)    				# vetor[i] = vetor[i+1]
        sw $t8, vetor($t5)    				# vetor[i+1] = aux

        # Marca trocado como true
        li $s0, 1             				# trocado = true

    	proxIndice:
        addi $t0, $t0, 1      				# i = i + 1
        j forLoop             				# Vai para a próxima iteração do loop

    	endFor:
        # Testa se trocado ainda é true
        bne $s0, $zero, doWhile  			# Se trocado == true, repete o loop do-while

        jr $ra              				# Retorna para o chamador

main:
	li $t0, 0					# $t0 vai ser o índice do vetor (i)

loopInput:
	# imprime "Digite o elemento do vetor: "
	li $v0, 4
	la $a0, entradaElementoVetor
	syscall
	
	# recebe o valor do vetor e o coloca no índice correto
	li $v0, 5
	syscall
	mul $t3, $t0, 4
	sw $v0, vetor($t3)
	
	addi $t0, $t0, 1
	bne $t0, 10, loopInput				# repete até preencher 10 elementos

li $t0, 0
jal bubbleSort						# chama o bubbleSort e linka no $ra

li $v0, 4               				
la $a0, saida      					
syscall

li $t0, 0               				# Reinicia o índice para percorrer o array do 0 novamente

printLoop:
	mul $t3, $t0, 4			 		# Multiplica t0 por 4 para calcular o offset correto     
    	lw $a0, vetor($t3)      			# Carrega o valor do array no registrador a0
    	li $v0, 1               			# Syscall para imprimir inteiro
    	syscall

    	li $v0, 4               			# Syscall para imprimir espaço
    	la $a0, espace
    	syscall

    	addi $t0, $t0, 1        			# Incrementa o índice

    	bne $t0, 10, printLoop  			# Continua até imprimir todos os 10 elementos

	
