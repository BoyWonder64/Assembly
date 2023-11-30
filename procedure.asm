# name: Maitland Andrus
# date: 6/22/2023
# description: Practice Procedures


# a lost of the functions, just another segment/directive
.globl main, hello_world, hello_message


# data
.data
Hello: .asciiz "Hello from my procedure!\n"
newline: .asciiz "\n"
Bye: .asciiz "That was a LOT of fun!!!\n"
Message: .asciiz "Hello! I am a parameter inside a procedure!\n"
Message1: .asciiz "We are creating procedures!\n"

Prompt: .asciiz "\nPlease enter a message to be printed:"

text: .space 256


# text - code goes here
.text


main: # a label, we are familar with main()
# Pseudocode
# expand formant
# write procedeure pseudocode
# create the string to print
# create the procedure, begin and end labels
# write the procedure operation
# call it from main

       
       
       
       
       # call the procedure
       jal hello_world # jal sets $ra to the address of the next instruction
	
       # force a newline
       li $v0, 4  # print a string
       la $a0, newline
       syscall

       # call helloWorld(message)
       # load message into argument a0
       la $a0, Message
       
       
       # call the procedure
       jal hello_message # jump and link to the procedure
       
       # force a newline
       li $v0, 4  # print a string
       la $a0, newline
       syscall
       
       # do it again with another message
       la $a0, Message1 # set up the argument 
       jal hello_message # call procedure
       
       li $v0, 4
       la $a0, Prompt
       syscall
	
       li $a1, 256
       li $v0, 8  # read a string		
       la $a0, text  # set argument  (address to store read)
       syscall
 	
       jal hello_message
       
      
       
       

       
      
       
       
end_main:  # exit
	# graceful close
	li $v0, 4    # print a string
	la $a0, Bye
	syscall
	# clean exit
	li $v0, 10
	syscall
	
# PROCEDURE void helloWorld()
#    print(hello world message)

# register mapping
# none

hello_world:

	li $v0, 4       # print a string
	la $a0, Hello
	syscall

end_hello_world:
       jr $ra  
       
    
       
# PROCEDURE void helloMessage(string message)
#    print( message)

# register mapping
# $a0 = string to print
# return: none

         
hello_message:
	
	li $v0, 4  # Print a string
#	la $a0, Hello   # this will be set before the jal
	syscall
	
	
 
end_hello_message:
	 jr $ra