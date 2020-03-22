.data
A:	.word 0,1,2,3,4,5,6,7,8,9
Sum:	.word 0
i:	.word 0

.text
la $s4,A
lw $t0,i
lw $t7,Sum

while:
	mul $t1,$t0,4		#loading all the data addresses into a variable
	add $t1,$t1,$s4
	lw  $s0,0($t1)

	add $t7,$t7,$s0		#increments sum of A[i++]
	mul $t7,$t7,2		#increments sum *= 2
	addi $t0,$t0,1		#increases the value of i by one
	ble $t0,9,while		#continues increment until value of 9 is met
	sw $t7,Sum
	move $a0,$t7
	li $v0,1
	syscall			#prints value 