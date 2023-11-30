# name: Maitland
# date: 5/18
# description: read input, store in memory, and display response

# data segment; 
.data
prompt: .asciiz "What is your favorite number? \n"  # prompt 
favNum: .word 0 # number
display: .asciiz "The number you entered is: \n"   # display/read out
display2: .asciiz "The number minus 82 is: "    # display/read out

# txt segment
.text

# ask for a number
# print a string
	li $v0, 4  	# print string
	la $a0, prompt  # set argument
	syscall
		
# capture the answer
	li $v0, 5	 # read integer
	syscall
	move $t0, $v0     # move the return value
	
#display the input
	# print the display
	li $v0, 4         # print string
	la $a0, display	  # set argument
	syscall
	# print the number
	li $v0, 1          # print string
	move $a0, $t0	  # set argument
	syscall

# do some math - subtract 82 from the number and store the difference in $t1
	subi $t1, $t0, 82
# save the difference to favNum (label stored in memory)
	sw $t1, favNum    # store word

# retrive it from memory and print
	lw $t3, favNum   # load word into $t3
	
	#force a new line - version 2
	li $v0, 11    # print a character
	la $a0, 0x0a  # hexadecimal newline
	syscall
	
	# print the display2
	li $v0, 4
	la $a0, display2
	syscall
	
	li $v0, 1      # print int
	move $a0, $t3  # set argument 
	syscall
	# print the difference 

# clean exit
	li $v0, 10      #exit program
	syscall

