# name: Maitland Andrus
# date: 6/22/23
# description: create a procedure with two parameters and a return value
# 	read in two ints, add them together and print the results

# remember the expanded format 


# globl directive list of procedures 
.globl main


# data
.data
sumString: .asciiz "\nThe sum is: "
close: .asciiz "\n\nHave a fruitful day\n"
prompt: .asciiz "\nEnter a number: "
prompt2: .asciiz "Enter another number: "



# text segment
.text

main: 
	# test the procedure with two hardcoded ints
	# load the arguments
	li $a0, 10
	li $a1, 15
	jal add_two	# return value is in $v0
	move $s0, $v0	# save results into $a0 so we can print
	
	# print results label
	li $v0, 4  # print a string
	la $a0, sumString
	syscall

	
	# print total
	li $v0, 1  # print a int
	move $a0, $s0
	syscall

#	prompt for 2 ints and run again

	li $v0, 4  # print a string
	la $a0, prompt
	syscall
	
	# capture an int
	li $v0, 5  # read an int
	syscall
	move $t2, $v0 # move to $t2
	
	li $v0, 4  # print a string
	la $a0, prompt2
	syscall
	
	# capture an int
	li $v0, 5  # read an int
	syscall
	move $t3, $v0 # move to $t3
	
	# load the arguments and call procedure
	move $a0, $t2
	move $a1, $t3
	jal add_two
	move $s0, $v0
	
	
	
	# print results label
	li $v0, 4  # print a string
	la $a0, sumString
	syscall
	
	# print total
	li $v0, 1  # print a int
	move $a0, $s0
	syscall
	
	
	#Your turn find the difference
	
	# load the arguments and call procedure
	move $a0, $t2
	move $a1, $t3
	jal sub_two
	move $s0, $v0
	
	
	
	# print results label
	li $v0, 4  # print a string
	la $a0, sumString
	syscall
	
	# print total
	li $v0, 1  # print a int
	move $a0, $s0
	syscall
	


end_main: # exit
	
	# graceful close
	li $v0, 4
	la $a0, close
	syscall
	
	# clean exit
	li $v0, 10
	syscall

# Procedure int AddTwo(int num1, int num2)
#	int total = num1 + num2
#	return total
#
# registers
# $a0 = num1
# $a0 = num2
# 
# return: $v0 = total


add_two:
	
	# get in habit of moving the arguments into temp registers
	move $t0, $a0 # if we need $a0, $a1 values we still need to have the orginal value
	move $t1, $a1
	
	# add them, store them into $v0
	add $v0, $t0, $t1
	
	
end_add_two:
	jr $ra
	
sub_two:
	
	# get in habit of moving the arguments into temp registers
	move $t0, $a0 # if we need $a0, $a1 values we still need to have the orginal value
	move $t1, $a1
	
	# add them, store them into $v0
	sub $v0, $t0, $t1
	
	
end_sub_two:
	jr $ra
