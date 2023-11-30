#
# Name: Maitland Andrus
# Date 6/13/2023
# Description: Looping, add the elements of an array
#

# data: Labels go here
.data
total: .word 0 # int variable
Fibs: .word 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144# an array



# text segment: Code goes here
.text



# Pseudocode:
#	foreach(fib in Fibs) {
#	   fib = Fibs[i]
#	} end foreach
#
#
# registers:
# fib = $t0
# i = $t1
# temp var = $t2


	# set i to zero
	li $t1, 0
loop:

	beq $t0 , 144, endloop # loop condition, branch when we get to 144
	lw $t0, Fibs($t1)      # fib = Fibs[i]
	add $t2, $t2, $t0      # temp += fib
	
	
	addi $t1, $t1, 4       #increment i, i++, (4 bytes, .word)
	
	

	j loop		  # Repeat, loop
endloop:

	# store the answer in total (label)
	sw $t2, total
	
	#print the answer
	li $v0, 1		# print int
	lw $a0, total
	syscall

# clean exit
	li $v0, 10
	syscall


