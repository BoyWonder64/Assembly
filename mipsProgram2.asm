# name: Maitland Andrus
# date: 6/9/23
# description: Read in an int, if greater than 10 print out a string of the users choice that many times. Then close the program.


# Labels go here
.data
name: .asciiz "Maitland Andrus\n"
class: .asciiz "CS2810 Program #2\n"
newLine: .asciiz "\n"

bye: .asciiz "\nBye"

prompt: .asciiz "Enter a number greater than or equal to 10:"
prompt2: .asciiz "Please enter your favorite string of words:"

word: .space 256

lessAns: .asciiz "You entered a number less than 10\n"
greaterAns: .asciiz "You entered a number greater than 10\n"

# code goes here
.text

# Section 1
# Pseudocode:

# Registers used:

#$s0 = number from prompt
#$s1 = store the value 10 to check agasint
#$t0 = i (counter var)

li $t0, 0   # i = 0 (iterator)
 
  #Task 1, Print name, class, and closing message
  li $v0, 4      # print string
la $a0, name
syscall

li $v0, 4      # print string
la $a0, class
syscall

li $v0, 4      # print string
la $a0, newLine
syscall




#Task 2: Capture a number
#Print(prompt)
#capture input and save it to $s0

#Pseudocode:
# if(num < 10) {
# print(lessAns)
# jump to end: bye
#} else {
# print(greaterAns)
#}

li $s1, 10     # value to check against


#Prompt the user for number
li $v0, 4      # print string
la $a0, prompt
syscall


# read in the prompt as an int
li $v0, 5
syscall       # read int
move $s0, $v0 # move it to $s0



# if $s0 < 10 go to else
bltu $s0, 10, else
# otherwise print greater than
li $v0, 4      # print string
la $a0, greaterAns
syscall





# Task 3: Capture String
# Print(prompt2)
# input = readStr()

# loop if($s0 > 10){
# while($s0 > 0) {
# print(input)
# $s0 = $s0 - 1
# 	}
# }

# Print out Prompt 2
li $v0, 4      # print string
la $a0, prompt2
syscall

li $a1, 256 # size of input buffer


# read in the prompt as an string
li $v0, 8
la $a0, word
syscall       # read int




Loop:
beq $t0, $s0, exit # if (i == numInput) break out of loop

li $v0, 4 #print string
la $a0, word
syscall

addi $t0, $t0, 1
# then exit
j Loop



else:
# print greater than
li $v0, 4      # print string
la $a0, lessAns
syscall
j exit  # go to exit






exit:


# Print new line
li $v0, 4      # print string
la $a0, newLine
syscall


li $v0, 4      # print string
la $a0, bye
syscall


# clean exit
li $v0, 10
syscall
