# 
# Name: Maitland Andrus
# Date: 6/13/2023
# Description: echo the users input
#

# data
.data
intro: .asciiz "Say something to the parrot and itll say it back! \n\n"# introduction
prompt: .asciiz "You say: "   # prompt
parrot: .asciiz "Parrot says: "   # parrot

# text to store input, save space for 255 chars, plus the null char
text: .space 256



# text
.text

# Pseudocode
#	print (intro)
#	while (i != limit) {
#		print(prompt)
#		text = readString()
#		print(parrot)
#		print(text)
#		increment i
#	} // end while
#
# registers
# i -= $t0
# limit = $t1
# input buffer = $a1
#

# print intro
	li $v0, 4
	la $a0, intro
	syscall
	
#set up i and limit and the input buffer
	li $t0, 0   # i = 0
	li $t1, 2   # limit = 2
	li $a1, 256 # size of input buffer
	
	
# add the loop
loop:
	# every time though the loop.
	beq $t0, $t1, endloop # if (i == limit) break out of loop
	
	li $v0, 4	# print prompt
	la $a0, prompt
	syscall
		
		
	# read the input string
	li $v0, 8  # read a string		
	la $a0, text  # set argument  (address to store read)
	# already set a1 to buffer size on line 41
	syscall
	
	
	li $v0, 4 # print parrot
	la $a0, parrot
	syscall
		
	# print input text
	li $v0, 4		#print string
	la $a0, text
	syscall
	
	
	# increment i
	addi $t0, $t0, 1    # i = i++

	j loop
	
endloop:

# clean exit
	li $v0, 10
	syscall
# 
