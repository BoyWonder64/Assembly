# Author: Maitland Andrus
# Date: 8/10/23
# Description: Parse MIPS instructions based on opcode and print message

# macro print string
.macro print_str(%str)
	li $v0, 4
	la $a0, %str
	syscall
.end_macro		

.globl main, decode_instruction, process_instruction, print_hex_info, print_opcode_type			# Do not remove this line
	

# Data for the program goes here
.data
	process: .asciiz "\nNow processing instruction "
	opcode_num: .asciiz "\tThe opcode value is: "
	newLine: .asciiz "\n"
	

	# number of test cases
	CASES: .word 5
	# array of pointers (addresses) to the instructions
	instructions:	.word 0x01095020, 		# add $t2, $t0, $t1
			.word 0x1220002C,  		# beqz $s1, label
			.word 0x3C011001,		# lw $a0, label($s0)
			.word 0x24020004,		# li $v0, 4
			.word 0xpizza		# j label
				

		
	inst_0:		.asciiz "\tR-Type Instruction\n"
	inst_other:	.asciiz "\tUnsupported Instruction\n"
	inst_2_3:	.asciiz "\tUnconditional Jump\n"
	inst_4_5:	.asciiz "\tConditional Jump\n"
	

	# You may use this array of labels to print the different instructions type messages
	inst_types: .word inst_0, inst_other, inst_2_3, inst_2_3, inst_4_5, inst_4_5
	

# Code goes here
.text
main:
	# Task 1A: Loop over the array of instructions 
	
li $t1, 0 # set counter
loop_array:
		
	# 	Set registers and call: print_hex_info
	bgt $t1, 16, end_main     # once we get 16 bits we want to end
	lw $t0, instructions($t1) #Load the instructions from t1 and put into t0
	la $a0, process # load process
	la $a1, ($t0) 
	# 	Set registers and call: 
	jal print_hex_info
	addi $t1, $t1, 4 
	
		

	# 	Set registers and call: 
	jal decode_instruction 
		
	# Update branch and index values
	subi  $sp, $sp, 36
		
	# Update branch and index values
	print_str(newLine)
		
	j loop_array		# end of loop
			
		
end_main:
	#graceful close
	li $v0, 10		# 10 is the exit program syscall
	syscall			# execute call
###############################################################
	

## Other procedures here ##
	

###############################################################
# Print Message based on opcode type
#
# $a0 - Message to print
# $a1 - Value to print
# Uses $s0: address of string for $a0 (required)
# Uses $s1: value from $a1 (required)
print_hex_info:
	##### Begin Save registers to Stack
	subi  $sp, $sp, 36
	sw   $ra, 32($sp)
	sw   $s0, 28($sp)
	sw   $s1, 24($sp)
	##### End Save registers to Stack
	

	# Now your function begins here
	move $s0, $a0
	move $s1, $a1
		
	li $v0, 4				# print message
	move $a0, $s0
	syscall
		
	li $v0, 34				# print address in hex value
	move $a0, $s1
	syscall
		
	li $v0, 4				# print message
	la $a0, newLine
	syscall
	

end_print_hex_info:
	##### Begin Restore registers from Stack
	lw   $ra, 32($sp)
	lw   $s0, 28($sp)
	lw   $s1, 24($sp)
	addi $sp, $sp, 36
	##### End Restore registers from Stack
		
    jr $ra
###############################################################


###############################################################
# Fetch instruction to correct procedure based on opcode for
# instruction parsing.
# Argument parameters:
# $a0 - input, 32-bit instruction to process (required)
# Return Value:
# $v0 - output, instruction opcode (bits 31-26) value (required)
# Uses:
# $s0: for input parameter (required)
# $s1: for opcode value (required)
# $t7: hold value for opcode
decode_instruction:
li $t7, 0 # optcode
# Save registers to Stack
	subi $sp, $sp, 36
	sw $ra, 32($sp)
	sw $s0, 28($sp)
# Your function "real" code begins here
	move $s0, $a0 # put s0 into a0
	move $s1, $a1 # put s1 into a1
# Isolate opcode (bits 31-26) 1111 1100 0000 0000 0000 0000 0000 0000
	srl $t7, $s1, 26 #isolate bits

	
# Task 3 (later): Set/Values call 
	jal print_opcode_type
# Set return value
end_decode_instruction:
# Restore registers from Stack
	lw   $ra, 32($sp)
	lw   $s0, 28($sp)
	lw   $s1, 24($sp)
	addi $sp, $sp, 36
jr $ra




###############################################################
# Print Opcode Type
# Argument parameters:
# $a0 - input, 32-bit instruction to process
# Uses: 
# t7 - opcode
print_opcode_type:
# Save registers to Stack
	move $s0, $a0
# Your function code begins here
	beqz $t7, rType  #if t7 == 0
	beq $t7, 2, unconditionalBranch #if t7 == 2
	beq $t7, 3, unconditionalBranch #if t7 == 3
	beq $t7, 4, conditionalBranch #if t7 == 4
	beq $t7, 5, conditionalBranch #if t7 == 5
	bgt $t7, 5, unsupported #if t7 > 5

rType:
	print_str(inst_0) # print string
	j process_instruction # jump to instruction
unconditionalBranch:
	print_str(inst_2_3)  # print string
	j process_instruction # jump to instruction
 
conditionalBranch:
	print_str(inst_4_5) # print string
	j process_instruction # jump to instruction
	
unsupported:
	print_str(inst_other) # print string
	j process_instruction # jump to instruction


end_print_opcode_type:
jr $ra

process_instruction:
	print_str(opcode_num)
	
        li $v0, 34 	            # print hex value
        move $a0, $t7
        syscall


end_process_instruction:
	jr $ra

