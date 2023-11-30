# Maitland Andrus
# 6/8/2023

# Test cases:
# input 4 and expect the output 32
# input 101 and expect the output 113
# input 105 and expect the output 117
# input 6 and expect ethe output 64
# input ! and expect the program to terminate with errors



# read an int
# if input < 100
	# multiply by 8
# else
	# add 12
# display answer


#labels go here
.data
prompt1: .asciiz "Enter a number: "
prompt3: .asciiz "\nThe answer is " 




#code goes here
.text

	li $s1, 100     # value to check against
	li $s4, 12


#	print prompt 1
	li $v0, 4      # print string
	la $a0, prompt1
	syscall


#	read an int
	li $v0, 5
	syscall       # read int
	move $s2, $v0 # move it to $s3

#	if $s2 < 100 go to else
	bltu $s2, 100, else
#	otherwise perform adding
	add $s2, $s2, 12
#	then exit
	j exit
	
			
else:
#	multiply ($s2 * 8)
	mul $s2, $s2, 8


exit:

#	print the answer
	li $v0, 4      # print string
	la $a0, prompt3
	syscall
	
#	print the int
	li $v0, 1      # print int
	move $a0, $s2
	syscall
	

#	clean exit
	li $v0, 10
	syscall

