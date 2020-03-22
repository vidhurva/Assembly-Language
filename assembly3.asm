.data

A:	.word 0,1,2,3,4,5,6,7,8,9
Sum:	.word 0
i:	.word 0

.text

la $s4,A
lw $t0,i
lw $t7, Sum

while:
	beq $t0, 10, exit
	lw $t2, A($t0)
	addi $t0, $t0, 4
	li $v0, 1
	move $a0, $t6
	syscall
	
	#li $v0, 4
	#la $a0, 
	#syscall
	
	j while
exit:
	li $v0, 10
	syscall 
	
	
