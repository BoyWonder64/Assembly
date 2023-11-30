# name: Maitland Andrus
# date: 6/8
# description: Practice an if, if else

# data segments
.data
prompt1: .asciiz "Enter a number: "
prompt2: .asciiz "Enter another number: "
prompt3: .asciiz "\nThe answer is " 


# Pseudocode
#	 print(prompt1)
#	 read (int)
#	 print(prompt2)
#	 read (int)
	
#	 if (i == j) 
#	   f == g + h
#	 else
#	    f == g - h
	
# register mapping
# $s0 = f
# $s1 = g
# $s2 = h	
# $s3 = i
# $s4 = j	



# text segment (code goes here
.text



#	set the values of g and h
	li $s1, 12      # g = 12
	li $s2, 15      # h = 15
	
#	print prompt 1
	li $v0, 4      # print string
	la $a0, prompt1
	syscall
	
#	read an int
	li $v0, 5
	syscall       # read int
	move $s3, $v0 # move it to $s3

#	print prompt 2
	li $v0, 4      # print string
	la $a0, prompt2
	syscall
	
#	read an int
	li $v0, 5
	syscall       # read int
	move $s4, $v0 # move it to $s3

#	this is what we want to do
#	if(i != j) branch to else and subtract
#	if they are the same, stay and add
#	
	bne $s3, $s4, else   # if(i != j) branch to else
	add $s0, $s1, $s2	# f = g + h
	j exit # jump past the else to exit
else: 
	sub $s0, $s1, $s2   # f = g - h
exit: 

#	print the answer
	li $v0, 4      # print string
	la $a0, prompt3
	syscall
	
#	print the int
	li $v0, 1      # print int
	move $a0, $s0
	syscall
	

	
#	Pesudocode
#	Add the two numbers sum = i + j
#	if sum = 0
#	   print (the answer is 0)
#	else
#	   divide the sum by 16
#	   print (the answer is answer)


# more registers
# $s3 = i
# $s4 = j	
# $s5 = sum
# $s6 = answer


#	add the two numbers sum = i + j
	add $s5, $s3, $s4
	
	# if (i + j) != 0 branch away and divide by 16
	# otherwise, print sum
	
#	bne, $s5, $0
	bnez $s5, else1
	
	
	# print (the answer is zero)
	# print the prmot
	li $v0, 4
	la $a0, prompt3
	syscall
	
	# print a 0
	li $v0, 1
	move $a0, $0
	syscall
	
	j exit1 # jump to end
	
	
else1:
	# divide by 16, shift right by 2^4 = 16 and put into $s6
	srl $s6, $s5, 4 
	# print (the answer is answer) 
	li $v0, 4
	la $a0, prompt3
	syscall
	
	# print the answer
	li $v0, 1
	move $a0, $s6
	syscall

exit1:


#	clean exit
	li $v0, 10
	syscall


