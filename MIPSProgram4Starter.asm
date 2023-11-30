# Author: Maitland Andrus
# Date: 7/25
# Description:  IEEE 754 Single Point Precision Calculator 

.macro print_str (%string)
	la    $a0, %string
	li    $v0, 4
	syscall
.end_macro

.globl read_float, print_sign, print_exp, print_significand, main	# Do not remove this line

# Data for the program goes here
.data

ieee: .word 0      # store your input here
again: .asciiz "Do you want to do it again?"
prompt: .asciiz "Maitland Andrus\nCS2810 Summer 2023\nEnter an IEEE 754 floating point number in decimal form: "
res_sign: .asciiz "\nThe sign is "
positive : .asciiz "Postive: "
negative: .asciiz "Negative: "
new_line: .asciiz "\n"
expoBias:	.asciiz "\nExpo with bias: "
expoNoBias:	.asciiz "\nExpo without bias: "
manti:		.asciiz "\nMantissa: "
sieee:		.asciiz "\nIEEE-754 Single Prec: "
	
.text 				# Code goes here
main:

# Registers used:
# t0 - hold user input
# t1 - yes or no prompt
# t2 - holds 0 to compare yes or no prompt
li $t2, 0 # set t2 to 0

	jal read_float
	jal print_sign
	jal print_exp
	jal print_significand
	
	print_str(sieee)
	li $v0, 34 	    # print int
   	move $a0, $t0
    	syscall
    
	print_str(new_line)
	

	# Task 6: Print IEEE number in hex
	# print exponent with bias (hex)
	
	# Task 1: Try again pop-up
pop_up:	
	
# Wanna do it again?
	# GUI prompt and capture	
	li $v0, 50 # display an int prompt
	la $a0, again
	syscall
	move $t1, $a0      	# move the return somewhere
	blt $t2 $t1 exit_main   # if (t2 < t1){
				#  exit()
				# } else {
				#      jump to main again
	j main
end_pop_up:
jr $ra	


		
exit_main:
	li    $v0, 10		# 10 is the exit program syscall
	syscall			# execute call
	
		
# Task 2: Call read_float()
	
################################################################
# Procedure void read_float()
# Functional Description: Reads input from user using a pop up
# gui. It stores the capture value in ieee memory space
# Argument parameters: None
# Return Value: None
################################################################
# Register Usage:
# t0 - holds  IEEE value

read_float:
# GUI prompt and capture	
	li $v0, 52 	# display an int prompt
	la $a0, prompt
	syscall	
	mfc1 $t0, $f0 	# copy register $f0 to $t0
	sw $t0, ieee  	# save input into ieee

read_float_ret:
jr $ra

	# Task 3: Call print_sign(ieee)
	
################################################################
# Procedure void print_sign(ieee)
# Functional Description: Extracts the sign bit from the input param
# and prints it to the screen with a corresponding message
# Argument parameters:
# $a0: ieee single precession value
# Return Value: None
#
# Note: sign character: 0x2B = '+', 0x2D = '-'
################################################################
# Register Usage:
# $t4 - hold shift for sign
# 
 
print_sign:
# The sing bit is the most significand bit. To isolate this bit you can use and AND
# to clear the other bits, then shift left 30 bits.
# print_str(res_sign)
# print char(- or +)

     print_str(res_sign)
     srl $t4, $t0, 31            # shift right 31 bits to get sign bit
     # if equal to = print postive
     beq $t4, 1, negativePrint   # if sign bit is 0, print +
     
# print the postive label     
positivePrint:                   

    print_str(positive)
    li $v0, 34 	            # print hex value
    move $a0, $t4
    syscall
    j end_print_sign		 # Go to next print_sigh
    
# print the negative labe
negativePrint:         

     print_str(negative)
     li $v0, 34 	           # print hex value
     move $a0, $t4
     syscall   
     j end_print_sign	# Go to next print_sight

   
end_print_sign:
jr $ra
	
	# Task 4: Call print_exp(ieee)
	
################################################################
# Procedure void print_exp(ieee)
# Functional Description: Extracts the exponent bits from the input param
# and prints it to the screen with a corresponding message
# Argument parameters:
# $a0: ieee single precession value
# Return Value: None
################################################################
# Register Usage:
# $t4 - Perform shifting against

print_exp:

# clear all but bits 30-23 
	sll $t4, $t4, 1
	srl $t4, $t4, 24
	
	# shift right 23
	srl $t4, $t0, 23           # shift right 31 bits to get sign bit
	
   	print_str(expoNoBias)      # print string to indicate sign bit
 	# print the hex value 
	li $v0, 34 	      # print hex
	move $a0, $t4
	syscall
	
# subtract bias (hex)
	subi  $t4, $t4, 127	      # shift for biased
# print_str(expoBias)

	 print_str(expoBias)      # print exponent with bias (hex)
	 li $v0, 34 	     # print int
	 move $a0, $t4
	 syscall
	

end_print_exp:
jr $ra
	
	# Task 5: Call print_significand(ieee)
	
################################################################
# Procedure void print_significand(ieee)
# Functional Description: Extracts the significand bits from the input param
# and prints it to the screen with a corresponding message
# Argument parameters:
# $a0: ieee single precession value
# Return Value: None
################################################################
# Register Usage:
# $t0 - Hold ieee value
# $t4 - Hold shift left by 9 
# $t6 - Hold shift left by 9 and include $t4
print_significand:
# clear all but bits 23-0(Mantissa)
# print_str(manti)
# print exponent with bias (hex) 
	sll $t4, $t0, 9	# Shift left 9 bits and store into $t4
	srl $t6, $t4, 9	# Shift right 9 bits and store into $t6
	print_str(manti)
			
	# print exponent with bias (hex)
	li $v0, 34 	    # print hex
	move $a0, $t6
	syscall

end_print_significand:
jr $ra



## end of ca.asm
