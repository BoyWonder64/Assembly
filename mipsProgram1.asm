# Author: Maitland Andrus
# Date: 5/23/2023
# Description: A program that asks for two integers, finds the difference, and then subtracts 20
# data segment, variables go here
.data
name: .asciiz "Maitland Andrus \n"
hw: .asciiz "Programing Assignment #1 \n"
info: .asciiz "A program that subtracts two numbers \n"
question1: .asciiz "Please enter a number:"
result: .asciiz "The difference between the two numbers is: "
newDiff: .asciiz "The new difference after subtracting 20 is: "

newLine: .asciiz "\n"


text: .word 0 # Number to be read in



# code goes here
.text

#Registers Used:
#  $t0 - used to hold the first number
#  $t1 - used to hold the second number
#  $t2 - used to hold the difference of $t0 and $t1



# Intro to Program
# Print a String

     li $v0, 4   # Print String
     la $a0, name # Set argument of string
     syscall

     li $v0, 4   # Print String
     la $a0, hw # Set argument of string
     syscall
     
     li $v0, 4   # Print String
     la $a0, info # Set argument of string
     syscall
     
     #add newline
     li $v0, 4   # Print String
     la $a0, newLine # Set argument of string
     syscall
     
# Capture Answer
     #Ask for number 1
     li $v0, 4   # Print String
     la $a0, question1 # Set argument of string
     syscall

     #Read in first Number
     li $v0, 5 # read integer
     syscall
     move $t0, $v0 # move the entered value into $t0
     
     #Ask for number 2
     li $v0, 4   # Print String
     la $a0, question1 # Set argument of string
     syscall
     
      #Read in Second Number
     li $v0, 5 # read integer
     syscall
     move $t1, $v0 # move the return value to $t1
     
     sub $t2, $t0, $t1  #subtract t1 from t0 and store it into t2
     
 
      #add newline
     li $v0, 4   # Print String
     la $a0, newLine # Set argument of string
     syscall
     
     
      #Print result
     li $v0, 4   # Print String
     la $a0, result # Set argument of string
     syscall
     
     li $v0, 1 # Print an integer
     move $a0, $t2
     syscall
     
     #add newline
     li $v0, 4   # Print String
     la $a0, newLine # Set argument of string
     syscall
     
     
     
#Subtract 20


     
     #subtract initial result and 20
     subi $t1, $t2, 20
     
     #store word: place result minus 20 into $t1
     sw $t1, text    # store word
     
        #Print difference prompt
     li $v0, 4   # Print String
     la $a0, newDiff # Set argument of string
     syscall  
     
     li $v0, 1      # print int
     move $a0, $t1  # set argument
     syscall
     
     #exit the program
     li $v0, 10 # set up system to exit
     syscall
     
     
     
     
     
     
     