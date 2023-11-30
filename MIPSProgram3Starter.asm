# Author: Maitland Andrus
# Date: 6/29/2023
# Description: Recieve name and output, take int and create times table for it

.macro read_int()
	li $v0, 5
	syscall
	# move from $v0 to a temp register
.end_macro

.globl main, user_info, mult_table			# Do not remove this line
# Data for the program goes here
.data
	#string constants
	info: 		.ascii "CS2810 MIPS Program 3\n"
			.asciiz "Welcome to the multiplication table program\n"
	prompt0:    	.asciiz "Please enter your name: "
	prompt1:	.asciiz "Up to what multiplication table do you want?\n" 
	message:  	.asciiz "\nHello: "
	bye:    	.asciiz "\nBye."
	tab: 		.asciiz "\t"
	nl:  		.asciiz "\n"		
	
	num: .word 0
	name: .space 80


# Code goes here
.text


###########
main:
	
	# Task 1: Call user_info procedure
	 jal user_info
	
	# Task 2: Capture integer input
		# print(prompt1)
	li   $v0, 4	# print string
	la   $a0, prompt1
	syscall

	
	# r = readInt()
	read_int()
	move $t2, $v0 # move to $t2
			
	# save register into num
	sw $t2, num
	
	# Task 3: Call mult_table procedure
	jal mult_table
	
exit_main:

	#Print newline
	li   $v0, 4	# print string
	la   $a0, nl
	syscall
	
	
	li   $v0, 4		# print(bye)
	la   $a0, bye
	syscall
	
	li $v0, 10		# 10 is the exit program syscall
	syscall			# execute call

## end of ca.asm


###############################################################
# Display User information
#
# $a0 - input, None
# $v0 - output, None
# $a1 - Buffer
user_info:
    	li   $v0, 4	# print string
	la   $a0, info
	syscall

	li   $v0, 4	# print(prompt)
	la   $a0, prompt0
	syscall

	# name = readString()
       	li $a1, 256
      	li $v0, 8  # read a string		
       	la $a0, name  # set argument  (address to store read)
       	syscall
	
	
	# print("hello" + name)
	li   $v0, 4	# print string
	la   $a0, message
	syscall
	
	li   $v0, 4	# print info
	la   $a0, name
	syscall


   
end_user_info:
	jr $ra


###############################################################
# Display Multiplication Table
#
# $a0 - input, None
# $v0 - output, None
# $t0  = i
# $t7 = j
# $t1 = i*j

# # Pseudocode for printing multiplication tables:
# // Print Multiplication tables 1 to num
# for(i=1; i<num; i++)
#    for(j=1; j<num; j++)
#          print(i*j)
#          print("\t")
#     print("\n")

mult_table:


lw $t2, num
li $t0, 0 # i
		######################## Begin Outer loop
loop1:		# start_loop_1: 
		
	bge $t0, $t2, exit_main  #(if i >= num)
	addi $t0, $t0, 1  # i++
	li $t7, 0         # reset J to 0 after each loop

	#Print newline
	li   $v0, 4	# print string
	la   $a0, nl
	syscall
	
		######################## Begin Inner loop

loop2:		# start_loop_2: 
	beq $t7, $t2 loop1  # if (t2 == t7) 
	
	addi $t7, $t7, 1   # j++
	mul $t1, $t0, $t7  # $t1 = i*j
	
	li $v0, 1 # print int
    	move $a0, $t1
	syscall
	
	#Print Tab
	li   $v0, 4	# print string
	la   $a0, tab
	syscall
	
	j loop2		# end_loop_2:
	
		######################## End Inner loop 	 
	
j loop1	# end_loop_1:  	
	
	######################## End Outer loop
	
end_mult_table:
        jr $ra
