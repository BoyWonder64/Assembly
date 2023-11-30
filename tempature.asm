# Name: Maitland Andrus
# Date: 6/27
# Description: Convert Tempatures

# macro to print to the $a0 argument
.macro printA(%info, %type)
	la $a0, %info
	li $v0, %type
	syscall
.end_macro

.macro print_str(%string)
	printA(%string, 4)
.end_macro

.macro read_char()
	li $v0, 12
	syscall
	# move from $v0 to a temp register
.end_macro

.macro print_char(%char)
	printA(%char, 11)
.end_macro

# macro to print to f12 argument
.macro printF(%info, %type)
	mov.s $f12, %info
	li $v0, %type
	syscall
.end_macro

.macro read_float()
	li $v0, 6
	syscall
	# move from $v0 to a temp register
.end_macro

.macro print_float(%float)
	printF(%float, 2)
.end_macro


.globl main, convertCel, convertFar


.data # Labels
hello: .asciiz "Welcome to Temps R Us!!\n" # greeting
bye: .asciiz "\n\nThanks for buying this program (Temps R us)"# close

typePrompt: .asciiz "Press C to convert a Celsius temprature. Press F to convert a Fahrenheit: "# type prompt
farPrompt: .asciiz "\nEnter the Fahrenheit tempture to convert: "# Far prompt
celPrompt: .asciiz "\nEnter the Celsius tempture to convert: "# Cel prompt

invalid: .asciiz "\n\n(Invalid Input)" # Invalid display 


# answer string = 22(degrees) Fahrenheit is 19(degrees) Celsius
answerF: .asciiz " Fahrenheit is "
answerC: .asciiz " Celsius is \n"
# constants for conversion
const5: .float 5.0 # constant 5.0
const9: .float 9.0 # constant 9.0
const32: .float 32.0 # constant 32.0

.text # Code goes here


main:

# pseudocode:
# friendly greeting
# prompt for conversion type
# if F, prompt Far temp, call convertFar, display the answer
# if C, prompt Cel temp, call convertCel, display the answer
# otherwise, print(invalid input)
# exit
#
# registers
# $t1 = conversion type
# $f20 = cel
# $f22 = far



# friendly greeting
	# print a string using the macro
	print_str(hello)

# prompt for conversion type
	# print a string
	print_str(typePrompt)
	
	
	# read the char input
	read_char()
	move $t1, $v0 # move from v0 to t1
	
	# branch to Fahrenheit if F or f
	beq $t1, 0x46, Fahrenheit # F - 0x46
	beq $t1, 0x66, Fahrenheit # f - 0x66
	
	
	# branch to Fahrenheit if C or c
	beq $t1, 0x43, Celsius # C - 0x46
	beq $t1, 0x63, Celsius # c - 0x66
	
	# otherwise branch to Invalid
	j Invalid
		 
Fahrenheit: 
# if F, prompt Far temp, call convertFar, display the answer
	print_str(farPrompt) # print macro
	read_float() # read the float
	mov.s $f22, $f0# move it from $f0 to $f22
	# call the procedure
	jal convertFar
	
	
	# print the answer
	mov.s $f20, $f0# move it from $f0 to $f22
	jal printAnswer
	
	j exit_main # exit 


Celsius: 
# if C, prompt Cel temp, call convertCel, display the answer
	print_str(celPrompt)
	read_float()
	mov.s $f20, $f0 # move from f0 to cel register(f20)

	# call the procedure
	jal convertCel
	
	# print the answer
	# load the argument register
	mov.s $f22, $f0
	jal printAnswer
	
	j exit_main # exit
	
Invalid: 
# otherwise, print(invalid input)
	print_str(invalid)

 j exit_main # exit


exit_main:

	# graceful close
	print_str(bye)
	
	# clean exit
	li $v0, 10
	syscall
	
# Procedure - convertCel(float cel)
#	float convertCel(float) {
#		return cel 9.0/5.0 + 32.0
#		} // end
#
# Registers
# $f20 = cel
# $f22 = far
# $f16, $f18 = constants
# $f0 = return value

convertCel:
	# return cel 9.0/5.0 + 32.0
	
	l.s $f16, const9 # load 9
	l.s $f18, const5 # load 5
	div.s $f16, $f16, $f18 # divide 9/5
	
	mul.s $f0, $f16, $f20 # mult 9/5 with cel
	
	l.s $f18, const32 # load 32
	add.s $f0, $f0, $f18 # add 32 to 9/5*cel
	
end_convertCel:
	jr $ra
 	
# Procedure - convertFar(float far)
#	float convertFar(float far) {
#		return (5.0/9.0) * (far - 32.0)
#	} // end 
#
# Registers
# $f20 = cel
# $f22 = far
# $f16, $f18 = constants
# $f0 = return value

convertFar:
	# return (5.0/9.0) * (far - 32.0)
	l.s $f16, const5 # load 5
	l.s $f18, const9 # load 9
	div.s $f16, $f16, $f18# divide 5/9  f16 = 5/9
	
	l.s $f18, const32 	# load 32
	sub.s $f18, $f22, $f18  # sub from far

	mul.s $f0, $f16, $f18 # mul 5/9 and far-32 (f18 = far-32) (f0 = 5/9 * far - 32)

end_convertFar:
	jr $ra

# procedure printAnswer(float far, float cel)
# print (answer)
#
#Registers
# far = f22
# cel = f20

printAnswer:

	print_float($f22)# print far
	print_char(0x00B0)# print degree symbol
	print_str(answerF)# print answerF
	
	print_float($f20)# print far
	print_char(0x00B0)# print degree symbol
	print_str(answerC)# print answerF

end_printAnswer:
 	jr $ra 
	
