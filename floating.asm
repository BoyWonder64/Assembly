# name: Maitland Andrus
# Description: Floating points
# date: 6/20/2023

#Labels
.data
bye: .asciiz "Bye" #Graceful close
newline: .asciiz "\n" # newline
prompt: .asciiz "Enter a floating point number: " 

#easiest way to load float immediate is to load it from memory
#float constants
const1: .float 15.0
const2: .float 6.0
const3: .float 19.25



#Pseudocode - all instructions are for floats IE single precision
# divide two floating points and display
# subtract a value and display
# read in float, multipy and display
#
# registers
#f16, f18
#code goes here
.text

# divide two single precision floats and print the answer
	l.s $f16, const1 # load 15.0
	l.s $f18, const2 # load 6.0
	div.s $f16, $f16, $f18# f16 = 15/6
	
	# print the quotient
	li $v0, 2 # print a float
	mov.s $f12, $f16 # load argument into f12
	syscall



	li $v0, 4
	la $a0, newline
	syscall

# subtract a float from the quotient and print again
	l.s $f18, const3 # load 19.25 into f18
	sub.s $f16, $f16, $f18 # f16 = f16 - 19.25
	
	
	# print the difference
	li $v0, 2 # print a float
	mov.s $f12, $f16 # load argument into f12
	syscall


	li $v0, 4 # print string
	la $a0, newline
	syscall
	
		
# read in float, multipy and display
	# prompt a float
	li $v0, 4
	la $a0, prompt
	syscall
	
	# read in a float
	li $v0, 6
	syscall
	mov.s $f18, $f0
	
	# multiply input with difference 
	mul.s $f16, $f16, $f18 # f16 = f16 * f18
	
	
	# print float
	# print the product
	li $v0, 2
	mov.s $f12, $f16
	syscall
	
	li $v0, 4 # print string
	la $a0, newline
	syscall


#ending 
end: 
	li $v0, 4 # print string
	la $a0, newline
	syscall
	
	# graceful close
	li $v0, 4
	la $a0, bye
	syscall
	
	# clean exit
	li $v0, 10
	syscall