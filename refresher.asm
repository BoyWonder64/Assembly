# description: refresher on MIPS assembly

# data segment - data labels
.data
greeting: .asciiz "Welcome to my MIPS program \n" # greeting string
newline: .asciiz "\n"
close: .asciiz "Thanks, and please try and have a better day \n"  #closing string
# closing string


# text segment - code
.text


# friendly greeting
    li $v0, 4 #print a string
    la $a0, greeting # set up the argument
    syscall
    
    
    
#add 4 and 8, and display the results
	
	
		# put 4 and 8 into registers, $t0, $t1
		li $t0, 4
		li $t1, 8 
		
		# add them together, and put the sum in $t0
		add $t2, $t0, $t1  #command, destination, argument
	    
	        
	        # print the results
	        li $v0, 1  # print an int
	        move $a0, $t2  # set the argument
	        syscall   
	        
	        # print the new line
	        li $v0, 4   # print the string
	        la $a0, newline # set the argument
	        syscall
    
# graceful close
	li $v0, 4  #pring a string
	la $a0, close #set up the argument
	syscall
#print a string

# clean exit
	li $v0, 10
	syscall
	
	
	
	
	#pseduocode
	li $s0, g
	li $s1, h
	add $t0, $s0, $s1		#command, destination, argument
	
	li $s2, i
	li $s3, j
	add $t1, $s2, $s3	
	
	sub $s4, $t0, $t1
	
		