#outline
#array start 0,0,0,0...
#num 10 
#for(int i = 0; i < num; i = i + 1) 
#loop:
# i --> $t2
#num --> $s1
#sloc --> $s2
#offset --> $t1


#1000 array start = start[0]
#1004 start[1] --> sets i = 0
#1008 start[2] 
#1012 offset[3] --> sll $t1, $t0, 2 
#if i == num --> jump to exit:

# <= slock + offset
# j test/oc
#incement i
#jump to top of loop

.data

start:	.word 0,0,0,0,0,0,0,0,0,0              # first address to test + series of 10 0 values
sloc:	.word start
num:	.word 10			       # amount of data to test
ermsg:	.asciiz "Bad memory address at "       # error string
exmsg:	.asciiz "All memory locations working" #

.text
# Main program
		move	$s0,$zero		# counter set to zero
		lw	$s1,num		        # maximum value
		lw      $s2,sloc                # first address to be checked
		                                #
#For lab, build the loop. Hints are on the right

		
loop:	        
		beq   $t2, $s1, exit 	       	# starts the loop  
		sll   $t1, $t2, 2   		# shifts one to the left
		add   $a0, $s2, $t1		# stores the number
		jal   testloc			# calc (add or offset)the current address
		beqz  $v0, error 				# $v0 error
            	addi  $t2, $t2, 1		#increment the i by 1	    			# test this location
               	j loop 			        # exit with error
                	 			# otherwise move to next address
               	
						#
error:	 	la	$a0, ermsg		# error string
		li	$v0, 4			# specify Print String service
		syscall				# print the heading string	
						#
		move   	$a0, $s2	        # load the integer to be printed 
		li   	$v0, 1			# specify Print Integer service
		syscall				# prints the bad address
		li   	$v0, 10			# system call for exit
		syscall				# The program is finished. Exit.
						#
exit:	 	la	$a0, exmsg		# load address of the error string
		li	$v0, 4			# specify Print String service
		syscall				# print the heading string	
						#	
		li   	$v0, 10			# system call for exit
		syscall				# The program is finished. Exit.	
# 
# testloc procedure
#   will test a word memory location for any stuck bits by clearing and setting all bits
#   Input: expected $a0 to be the address of the location to be tested
#   Output: will set $v0 to 0 (false) for an error and 1 (true) for no error
#   uses no stack storage and calls no other procedures
#
testloc:	move	$t0,$zero		# first bit pattern to store will be all bits set to 0
		sw	$t0,0($a0)		# put this in the address to be tested
		lw	$t1,0($a0)		# read back what was in that address
		bne	$t0,$t1,badloc		# signal an error if all bits were not clear
		addi	$t0,$zero,-1		# second pattern will be all bits set to one (-1 = all ones)
		sw	$t0,0($a0)		# 
		lw	$t1,0($a0)		#
		bne	$t0,$t1,badloc		# if all ones not set, then signal and error
		addi	$v0,$zero,1		# successful return is $v0=1
		jr	$ra			# return
badloc:		addi	$v0,$zero,0		# unsuccessful return is $v0=0
		jr	$ra			# return
