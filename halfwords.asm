# Name: Maitland
# Date: 5/23/2023
# Description: practice with bytes and half words

# data segment - labels
.data

# a word is 4 bytes long (32 bits)
# a .half is 2 bytes or half a word (16 bits)
# a .byte is 1 byte (8 bits)

# create a date label with July 4, 1776
date: .byte 7     # month (7) 1 byte
      .byte 4     # day (4) 1 byte 
      .half 1776  # year (1776) - a decimal 1776 uses 11 binary bits
      
event: .asciiz "Declaration of Independence"      

space: .asciiz "/"

#text segment - code goes here
.text

# load the values into the registers
	# we can load the byte signed (pos or neg) or unsigned(pos)
	lbu $t0, date  # loads a 7 (the first byte)
	
	# load the next byte
	lbu $t1, date + 1  # loads a 4 (the second byte)
	
	# load the half word
	# load a half signed or unsigned
	lhu $t2, date + 2    # load 1776 0x6F0


# practice with a string
	# load the first letter of event into  $t3
	lbu $t3, event + 0	# get a 'D' or 0x0044
	
	# display the D
	li $v0, 11 # print a character

	move $a0, $t3 #t3 contains D
	syscall
	
# load the first letter of event into  $t3
	lbu $t3, event + 4	# get a 'D' or 0x0044
	
	# display the a
	li $v0, 11
	li $a0, 0x0a # display a newline
	syscall 
	
	# t3 now has the a
	move $a0, $t3
	syscall
	
	li $v0, 11
	li $a0, 0x0a # display a newline
	syscall

# print the date using the registers,  in a user friend  format
	li $v0, 1 # print an int
	move $a0, $t0 #set 
	syscall
	
	li $v0, 4 # print a /
	la $a0, space
	syscall
	
	li $v0, 1 # print an int
	move $a0, $t1
	syscall
	
	li $v0, 4 # print a /
	la $a0, space
	syscall
	
	li $v0, 1 # print an int
	move $a0, $t2
	syscall
	

#exit program
	li $v0, 10   #clean exit
	syscall