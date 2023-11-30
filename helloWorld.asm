# name : Maitland Andrus
# date: 5/16/23
# description: first MIPS program


# data segment - constants and variables (labels)
.data
hello: .asciiz "Hello World!!!! \n"
otherString: .asciiz "this is my other string"





# text segment - code (assembly instructions) go here
.text
	
	#print the string
	li $v0, 4	#load a 4 into $v0 to print a string
	la $a0, hello  #load the string to print
	syscall        #syscall
	
	
	#create another label and print it
	li $v0, 4
	la $a0, otherString
	syscall
	
	#clean exit
	li $v0, 10     	#exit the program	
	syscall


