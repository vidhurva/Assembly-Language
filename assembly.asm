.data 
	num1: .word 7
	num2: .word 10
	
	message: .asciiz "Hello MIPS World!\n" 
	
	declIndep: .word 1776
	
	PIDouble: .double 3.1415926535
	
	mychar: .byte '*'
	
.text 
	addi $t0, $zero, 2000	# t0 = 2000
	addi $t1, $zero, 10	# t1 = 10
	mult  $t0, $t1	# t0 * t1
	# result goes into hi and lo -> look at registers to right->
	mflo	$s0		# because it is small
	add $a0, $zero, $s0	
	
	li $v0, 1
	syscall  

	lw $t0, num1
	lw $t1, num2
	add $a0, $t0, $t1
	li $v0, 1
	syscall
	
	ldc1 $f2, PIDouble 
	ldc1 $f4, PIDouble 
	add.d $f12, $f2, $f4
	li $v0,3
	syscall
	
	li $v0,1  		# 1 is for integer	
	lw $a0, declIndep  	#load WORD
	syscall  		# do it!

	
	li $v0,4
	la $a0,message
	syscall
	
	li $v0,11  # 11 is for char	
	lw $a0, mychar  
	syscall  # do it!